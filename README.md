# PFAudioLib

[![CI Status](https://img.shields.io/travis/qq631192328/PFAudioLib.svg?style=flat)](https://travis-ci.org/qq631192328/PFAudioLib)
[![Version](https://img.shields.io/cocoapods/v/PFAudioLib.svg?style=flat)](https://cocoapods.org/pods/PFAudioLib)
[![License](https://img.shields.io/cocoapods/l/PFAudioLib.svg?style=flat)](https://cocoapods.org/pods/PFAudioLib)
[![Platform](https://img.shields.io/cocoapods/p/PFAudioLib.svg?style=flat)](https://cocoapods.org/pods/PFAudioLib)

## Introduction

iOS音频文件格式的转换工具    
支持pcm、mp3、wav、amr格式之间的相互转化

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Demo请参照PFAudioLib/TEST_SWIFT
### 设置好源文件的音频属性
```
首先设置好音频文件的属性
// 这个是音频文件的默认配置，如果你的因为文件不一致，可以进行改动
let configDic: [String: AnyObject] = [
    // 编码格式
    AVFormatIDKey: NSNumber(value: Int32(kAudioFormatLinearPCM)),
    // 采样率
    AVSampleRateKey: NSNumber(value: 8000),
    // 通道数
    AVNumberOfChannelsKey: NSNumber(value: 2),
    // 录音质量
    AVEncoderAudioQualityKey: NSNumber(value: Int32(AVAudioQuality.min.rawValue))
]
// 设置音频文件的属性
PFAudio.shareInstance()?.attrs = self.configDic
```
### 进行文件格式的转换
```
// 将pcm文件转换成amr，第一个参数是音频文件的路径，第二个参数是转化后是否需要将源文件删除
PFAudio.shareInstance()?.pcm2Amr(recordFilePath, isDeleteSourchFile: false)
// 将pcm文件转换成mp3，第一个参数是音频文件的路径，第二个参数是转化后是否需要将源文件删除
PFAudio.shareInstance()?.pcm2Mp3(recordFilePath, isDeleteSourchFile: false)
```

## Requirements

## Installation

PFAudioLib is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PFAudioLib'
```

## Author

qq631192328, hongpeifeng@163.com

## License

PFAudioLib is available under the MIT license. See the LICENSE file for more info.
