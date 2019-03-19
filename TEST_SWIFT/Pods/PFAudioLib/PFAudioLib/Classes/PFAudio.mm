//
//  PFAudio.m
//  PFAudio
//
//  Created by hpf on 17/2/7.
//  Copyright © 2017年 zmartec. All rights reserved.
//

#import "PFAudio.h"
#import "voiceAmrFileCodec.h"
#import "lame.h"

@implementation PFAudio

static PFAudio *instance;

+ (instancetype) shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance setDefaultAttr];
    });
    return instance;
}

- (void) setDefaultAttr {
    _attrs = [[NSDictionary alloc] initWithObjectsAndKeys:
              [NSNumber numberWithFloat: 8000],AVSampleRateKey, //采样率
              [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
              [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,//采样位数 默认 16
              [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,//通道的数目
              nil];
}

//转换amr到wav
- (BOOL) amr2Wav:(NSString *)amrPath isDeleteSourchFile:(BOOL)isDelete{
    NSString *outPath = [[amrPath stringByDeletingPathExtension] stringByAppendingString:@".wav"];
    BOOL isSuccess = DecodeAMRFileToWAVEFile([amrPath cStringUsingEncoding:NSASCIIStringEncoding], [outPath cStringUsingEncoding:NSASCIIStringEncoding]) ;
    if (isSuccess && isDelete) {
        NSFileManager *fm = [NSFileManager defaultManager];
        [fm removeItemAtPath:amrPath error:nil];
    }
    return isSuccess;
}

//转换wav到amr
- (BOOL) wav2Amr:(NSString *)wavPath isDeleteSourchFile:(BOOL)isDelete{
    // 输出路径
    NSString *outPath = [[wavPath stringByDeletingPathExtension] stringByAppendingString:@".amr"];
    int rateKey = [self.attrs[AVLinearPCMBitDepthKey] intValue];
    int numOfChannelsKey = [self.attrs[AVNumberOfChannelsKey] intValue];
    int resultCode = EncodeWAVEFileToAMRFile([wavPath cStringUsingEncoding:NSASCIIStringEncoding], [outPath cStringUsingEncoding:NSASCIIStringEncoding], numOfChannelsKey, rateKey);
    if (resultCode != 0 && isDelete) {
        NSFileManager *fm = [NSFileManager defaultManager];
        [fm removeItemAtPath:wavPath error:nil];
    }
    return resultCode != 0;
}

// pcm转wav
- (BOOL) pcm2Wav: (NSString *)pcmPath isDeleteSourchFile:(BOOL)isDelete{
    NSString *outPath = [[pcmPath stringByDeletingPathExtension] stringByAppendingString:@".wav"];
    NSData *data = [NSData dataWithContentsOfFile:pcmPath];
    BOOL isSuccess = [[self writeWavHead:data] writeToFile:outPath atomically:YES];
    if (isSuccess && isDelete) {
        NSFileManager *fm = [NSFileManager defaultManager];
        [fm removeItemAtPath:pcmPath error:nil];
    }
    return isSuccess;
}

// pcm装amr
- (BOOL) pcm2Amr:(NSString *)pcmPath isDeleteSourchFile:(BOOL)isDelete{
    if ([self pcm2Wav:pcmPath isDeleteSourchFile:isDelete]) {
        NSString *wavPath = [[pcmPath stringByDeletingPathExtension] stringByAppendingString:@".wav"];
        return [self wav2Amr:wavPath isDeleteSourchFile:isDelete];
    }
    return NO;
}

//pcm转mp3
- (BOOL) pcm2Mp3: (NSString *)pcmPath isDeleteSourchFile:(BOOL)isDelete
{
    
    // 输入路径
    NSString *inPath = pcmPath;
    
    // 判断输入路径是否存在
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:pcmPath])
    {
        NSLog(@"文件不存在");
        return NO;
    }
    
    // 输出路径
    NSString *outPath = [[pcmPath stringByDeletingPathExtension] stringByAppendingString:@".mp3"];
    @try {
        size_t read, write;
        
        FILE *pcm = fopen([inPath UTF8String], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([outPath UTF8String], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        int rateKey = [self.attrs[AVSampleRateKey] intValue];//[self.attrs[AVSampleRateKey] intValue];
        int numOfChannelsKey = [self.attrs[AVNumberOfChannelsKey] intValue];
        lame_set_in_samplerate(lame, rateKey);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        lame_set_num_channels(lame, numOfChannelsKey);//设置1为单通道，默认为2双通道
        lame_set_quality(lame, 0); /* 2=high 5 = medium 7=low 音质*/
        
        do {
            size_t size = (size_t)(2 * sizeof(short int));
            read = fread(pcm_buffer, size, PCM_SIZE, pcm);
            if (read == 0)
            write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
            write = lame_encode_buffer_interleaved(lame, pcm_buffer, (int)read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
        return NO;
    }
    @finally {
        NSLog(@"MP3生成成功:");
        if (isDelete) {
            
            NSError *error;
            [fm removeItemAtPath:pcmPath error:&error];
            if (error == nil)
            {
                NSLog(@"删除源文件成功");
            }
            
        }
        return YES;
    }
    
}

// 为pcm文件写入wav头
- (NSData*) writeWavHead:(NSData *)audioData {
    long sampleRate = [self.attrs[AVSampleRateKey] longValue];
    long numOfChannelsKey = [self.attrs[AVNumberOfChannelsKey] longValue];
    Byte waveHead[44];
    waveHead[0] = 'R';
    waveHead[1] = 'I';
    waveHead[2] = 'F';
    waveHead[3] = 'F';
    
    long totalDatalength = [audioData length] + 44;
    waveHead[4] = (Byte)(totalDatalength & 0xff);
    waveHead[5] = (Byte)((totalDatalength >> 8) & 0xff);
    waveHead[6] = (Byte)((totalDatalength >> 16) & 0xff);
    waveHead[7] = (Byte)((totalDatalength >> 24) & 0xff);
    
    waveHead[8] = 'W';
    waveHead[9] = 'A';
    waveHead[10] = 'V';
    waveHead[11] = 'E';
    
    waveHead[12] = 'f';
    waveHead[13] = 'm';
    waveHead[14] = 't';
    waveHead[15] = ' ';
    
    waveHead[16] = 16;  //size of 'fmt '
    waveHead[17] = 0;
    waveHead[18] = 0;
    waveHead[19] = 0;
    
    waveHead[20] = 1;   //format
    waveHead[21] = 0;
    
    waveHead[22] = numOfChannelsKey;   //chanel
    waveHead[23] = 0;
    
    waveHead[24] = (Byte)(sampleRate & 0xff);
    waveHead[25] = (Byte)((sampleRate >> 8) & 0xff);
    waveHead[26] = (Byte)((sampleRate >> 16) & 0xff);
    waveHead[27] = (Byte)((sampleRate >> 24) & 0xff);
    
    long byteRate = sampleRate * 2 * (16 >> 3);;
    waveHead[28] = (Byte)(byteRate & 0xff);
    waveHead[29] = (Byte)((byteRate >> 8) & 0xff);
    waveHead[30] = (Byte)((byteRate >> 16) & 0xff);
    waveHead[31] = (Byte)((byteRate >> 24) & 0xff);
    
    waveHead[32] = 2*(16 >> 3);
    waveHead[33] = 0;
    
    waveHead[34] = 16;
    waveHead[35] = 0;
    
    waveHead[36] = 'd';
    waveHead[37] = 'a';
    waveHead[38] = 't';
    waveHead[39] = 'a';
    
    long totalAudiolength = [audioData length];
    
    waveHead[40] = (Byte)(totalAudiolength & 0xff);
    waveHead[41] = (Byte)((totalAudiolength >> 8) & 0xff);
    waveHead[42] = (Byte)((totalAudiolength >> 16) & 0xff);
    waveHead[43] = (Byte)((totalAudiolength >> 24) & 0xff);
    
    NSMutableData *pcmData = [[NSMutableData alloc]initWithBytes:&waveHead length:sizeof(waveHead)];
    [pcmData appendData:audioData];
    
    
    return pcmData;
    
}

@end
