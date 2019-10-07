#
# Be sure to run `pod lib lint SwiftyExts.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyExts'
  s.version          = '0.0.1'
  s.summary          = 'SwiftyExts.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Swift分类扩展：SwiftyExts.
                       DESC

  s.homepage         = 'https://github.com/CoderDoraemon/SwiftyExts'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CoderDoraemon' => '277544354@qq.com' }
  s.source           = { :git => 'https://github.com/CoderDoraemon/SwiftyExts.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.requires_arc               = true

  s.swift_version = '5.0'
  s.default_subspec = 'Core'
  s.frameworks = 'Foundation'
  
  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
  s.watchos.deployment_target = '2.0'
  
  s.subspec 'Core' do |core|
    core.source_files = 'SwiftyExts/Core/**/*'
  end
  
  s.subspec 'Attributes' do |attributes|
  attributes.ios.deployment_target = '8.0'
  attributes.tvos.deployment_target = '9.0'
  attributes.osx.deployment_target = '10.11'
  attributes.watchos.deployment_target = '2.0'
    
    attributes.source_files = 'SwiftyExts/Attributes/**/*'
    attributes.dependency 'SwiftyExts/Core'
    attributes.dependency 'SwiftyAttributes', '>= 5.1.1'
  end
  
  s.subspec 'Device' do |device|
    device.ios.deployment_target = '8.0'
  
    device.source_files = 'SwiftyExts/Device/**/*'
    device.dependency 'SwiftyExts/Core'
    device.dependency 'DeviceKit', '>= 2.3.0'
  end
  
  s.subspec 'Reachability' do |reachability|
  reachability.ios.deployment_target = '8.0'
    reachability.source_files = 'SwiftyExts/Reachability/**/*'
    reachability.dependency 'SwiftyExts/Core'
    reachability.dependency 'ReachabilitySwift', '>= 4.3.1'
  end
  
  s.subspec 'Complete' do |complete|
  complete.ios.deployment_target = '8.0'
    complete.dependency 'SwiftyExts/Core'
    complete.dependency 'SwiftyExts/Attributes'
    complete.dependency 'SwiftyExts/Device'
    complete.dependency 'SwiftyExts/Reachability'
  end
  
  s.requires_arc = true
end
