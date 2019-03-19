//
//  ViewController.swift
//  TEST_SWIFT
//
//  Created by hongpeifeng on 2018/10/25.
//  Copyright © 2018 hongpeifeng. All rights reserved.
//

import UIKit
import AVFoundation
import PFAudioLib

class ViewController: UIViewController {
    
    let recordFilePath = "/Users/hpf/Desktop/test.pcm"
    
    // setting : 录音的设置项
    // 录音参数设置(不需要掌握, 一些固定的配置)
    let configDic: [String: AnyObject] = [
        // 编码格式
        AVFormatIDKey: NSNumber(value: Int32(kAudioFormatLinearPCM)),
        // 采样率
        AVSampleRateKey: NSNumber(value: 8000),
        // 通道数
        AVNumberOfChannelsKey: NSNumber(value: 2),
        // BPS
        AVLinearPCMBitDepthKey: NSNumber(value: 16),
        // 录音质量
        AVEncoderAudioQualityKey: NSNumber(value: Int32(AVAudioQuality.min.rawValue))
    ]
    
    lazy var record: AVAudioRecorder? = {
        // 开始录音
        
        // url : 录音文件的路径
        let url = NSURL(string: recordFilePath.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed) ?? "")
        
        print(configDic)
        do {
            let record = try AVAudioRecorder(url: url! as URL, settings: configDic)
            // 准备录音(系统会给我们分配一些资源)
            record.prepareToRecord()
            
            return record
            
        }catch {
            print(error)
            return nil
        }
        
        
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("开始录音")
        // 开始录音
        record?.record()
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("结束录音")
        // 结束录音
        record?.stop()
        //录音结束后文件会存放在recordFilePath路径下
        
        // 设置音频文件的属性
        PFAudio.shareInstance()?.attrs = self.configDic
        // 将pcm文件转换成amr
        PFAudio.shareInstance()?.pcm2Amr(recordFilePath, isDeleteSourchFile: false)
        // 将pcm文件转换成MP3
        PFAudio.shareInstance()?.pcm2Mp3(recordFilePath, isDeleteSourchFile: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

