#
# Be sure to run `pod lib lint SwiftyExts.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'SwiftyExts'
    s.version          = '1.0.1'
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
    
    s.swift_version = '5.0'
    s.ios.deployment_target = '8.0'
    s.default_subspec = 'Core'
    
    s.subspec 'Foundation' do |t|
        t.ios.deployment_target = '8.0'
        t.source_files = 'SwiftyExts/Core/Foundation+/**/*'
    end
    
    s.subspec 'UIKit' do |t|
        t.ios.deployment_target = '8.0'
        t.source_files = 'SwiftyExts/Core/UIKit+/**/*'
    end
    
    s.subspec 'Attributes' do |t|
        t.ios.deployment_target = '8.0'
        
        t.source_files = 'SwiftyExts/Attributes/**/*'
        t.dependency 'SwiftyExts/Core'
        t.dependency 'SwiftyAttributes', '>= 5.1.1'
    end
    
    s.subspec 'Core' do |t|
        t.ios.deployment_target = '8.0'
        t.dependency 'SwiftyExts/Core/Foundation'
        t.dependency 'SwiftyExts/Core/UIKit'
    end
    
    s.subspec 'Device' do |t|
        t.ios.deployment_target = '8.0'
        
        t.source_files = 'SwiftyExts/Device/**/*'
        t.dependency 'SwiftyExts/Core'
        t.dependency 'DeviceKit', '>= 2.3.0'
    end
    
    s.subspec 'Reachability' do |t|
        t.ios.deployment_target = '8.0'
        t.source_files = 'SwiftyExts/Reachability/**/*'
        t.dependency 'SwiftyExts/Core'
        t.dependency 'ReachabilitySwift', '>= 4.3.1'
    end
    
    s.subspec 'All' do |t|
        t.ios.deployment_target = '8.0'
        t.dependency 'SwiftyExts/Core'
        t.dependency 'SwiftyExts/Attributes'
        t.dependency 'SwiftyExts/Device'
        t.dependency 'SwiftyExts/Reachability'
    end
    
    s.requires_arc = true
end
