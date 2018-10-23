#
# Be sure to run `pod lib lint PFAudioLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PFAudioLib'
  s.version          = '0.1.0'
  s.summary          = '音频文件转换工具'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '音频文件转换工具 支持pcm,mp3,arm,wav文件格式的转换'

  s.homepage         = 'https://github.com/qq631192328/PFAudioLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'qq631192328' => 'hongpeifeng@163.com' }
  s.source           = { :git => 'https://github.com/qq631192328/PFAudioLib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PFAudioLib/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PFAudioLib' => ['PFAudioLib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
