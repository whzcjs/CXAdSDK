#
# Be sure to run `pod lib lint CXAdSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CXAdSDK'
  s.version          = '1.0.0'
  s.summary          = 'A short description of CXAdSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/whzcjs/CXAdSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'AustinYang' => '625635129@qq.com' }
  s.source           = { :git => 'https://github.com/whzcjs/CXAdSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

#  s.source_files = 'CXAdSDK/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CXAdSDK' => ['CXAdSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation', 'AdSupport', 'CoreTelephony', 'SystemConfiguration'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.pod_target_xcconfig = {
      'OTHER_LDFLAGS' => '-ObjC',
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64', # 解决模拟器架构问题
      'VALID_ARCHS' => 'arm64 armv7 x86_64' # 指定支持的架构
  }
  
  s.vendored_frameworks = 'CXAdSDK/Frameworks/*.xcframework'
  s.resource = 'CXAdSDK/Resources/CXAdsBundle.bundle'
  
  s.public_header_files = 'CXAdSDK/Frameworks/CXAdSDK.framework/Headers/*.h'
  
  
end
