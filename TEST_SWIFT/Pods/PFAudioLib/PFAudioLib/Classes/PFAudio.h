//
//  PFAudio.h
//  PFAudio
//  音频格式转换工具类
//  Created by hpf on 17/2/7.
//  Copyright © 2017年 zmartec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PFAudio : NSObject

// 音频文件的属性
@property (nonatomic,copy) NSDictionary *attrs;

+ (instancetype) shareInstance;

/**
 *  转换wav到amr
 *
 *  @param wavPath  wav文件路径
 *  @param isDelete 转换成功后是否删除源文件
 *
 *  @return NO 失败 YES成功
 */
- (BOOL) wav2Amr:(NSString *)wavPath isDeleteSourchFile:(BOOL)isDelete;

/**
 *  转换amr到wav
 *
 *  @param amrPath  amr文件路径
 *  @param isDelete 转换成功后是否删除源文件
 *
 *  @return NO 失败 YES成功
 */
- (BOOL) amr2Wav:(NSString *)amrPath isDeleteSourchFile:(BOOL)isDelete;

/**
 *  转换pcm到mp3
 *
 *  @param pcmPath  pcm文件路径
 *  @param isDelete 转换成功后是否删除源文件
 *
 *  @return NO 失败 YES成功
 */
- (BOOL) pcm2Mp3: (NSString *)pcmPath isDeleteSourchFile:(BOOL)isDelete;
/**
 *  转换pcm到wav
 *
 *  @param pcmPath  pcm文件路径
 *  @param isDelete 转换成功后是否删除源文件
 *
 *  @return NO 失败 YES成功
 */
- (BOOL) pcm2Wav: (NSString *)pcmPath isDeleteSourchFile:(BOOL)isDelete;

/**
 *  转换pcm到amr
 *
 *  @param pcmPath  pcm文件路径
 *  @param isDelete 转换成功后是否删除源文件
 *
 *  @return NO 失败 YES成功
 */
- (BOOL) pcm2Amr:(NSString *)pcmPath isDeleteSourchFile:(BOOL)isDelete;

/**
 *  为pcm文件写入wav头
 */
- (NSData*) writeWavHead:(NSData *)audioData;
void conventToMp3(NSString *pcmFile,NSString *mp3File);



@end
