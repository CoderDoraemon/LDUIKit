#
# Be sure to run `pod lib lint SwiftExtension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftExtension'
  s.version          = '1.0.0'
  s.summary          = 'SwiftExtension.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  SwiftExtension.
                       DESC

  s.homepage         = 'https://github.com/CoderDoraemon/SwiftExtension'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CoderDoraemon' => 'xfsrn@139.com' }
  s.source           = { :git => 'https://github.com/CoderDoraemon/SwiftExtension.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_version = '5.0'
  s.default_subspec = 'Core'
  s.frameworks = 'Foundation'
  
  s.requires_arc               = true
  s.ios.deployment_target      = '8.0'
  s.tvos.deployment_target     = '9.0'
  s.watchos.deployment_target  = '2.0'
  
  s.subspec 'Core' do |core|
    core.source_files = 'SwiftExtension/Core/**/*'
  end
  
  s.subspec 'Attributes' do |attributes|
    attributes.ios.deployment_target = '8.0'
    
    attributes.source_files = 'SwiftExtension/Attributes/**/*'
    attributes.dependency 'SwiftExtension/Core'
    attributes.dependency 'SwiftyAttributes', '>= 5.1.1'
  end
  
  s.subspec 'Device' do |device|
    device.ios.deployment_target = '8.0'
    
    device.source_files = 'SwiftExtension/Device/**/*'
    device.dependency 'SwiftExtension/Core'
    device.dependency 'DeviceKit', '>= 2.3.0'
  end
  
  s.subspec 'Reachability' do |reachability|
    reachability.ios.deployment_target = '8.0'
    
    reachability.source_files = 'SwiftExtension/Reachability/**/*'
    reachability.dependency 'SwiftExtension/Core'
    reachability.dependency 'ReachabilitySwift', '>= 4.3.1'
  end
  
  s.subspec 'Complete' do |complete|
    complete.ios.deployment_target = '8.0'

    complete.dependency 'SwiftExtension/Core'
    complete.dependency 'SwiftExtension/Attributes'
    complete.dependency 'SwiftExtension/Device'
    complete.dependency 'SwiftExtension/Reachability'
  end
  
  s.requires_arc = true
  
end
