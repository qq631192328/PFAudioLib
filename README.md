# PFAudioLib

[![CI Status](https://img.shields.io/travis/qq631192328/PFAudioLib.svg?style=flat)](https://travis-ci.org/qq631192328/PFAudioLib)
[![Version](https://img.shields.io/cocoapods/v/PFAudioLib.svg?style=flat)](https://cocoapods.org/pods/PFAudioLib)
[![License](https://img.shields.io/cocoapods/l/PFAudioLib.svg?style=flat)](https://cocoapods.org/pods/PFAudioLib)
[![Platform](https://img.shields.io/cocoapods/p/PFAudioLib.svg?style=flat)](https://cocoapods.org/pods/PFAudioLib)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
```
// 设置音频文件的属性
PFAudio.shareInstance()?.attrs = self.configDic
// 将pcm文件转换成amr
PFAudio.shareInstance()?.pcm2Amr(recordFilePath, isDeleteSourchFile: false)
// 将pcm文件转换成MP3
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
