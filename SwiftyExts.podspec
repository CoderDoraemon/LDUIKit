Pod::Spec.new do |s|
    s.name             = 'SwiftyExts'
    
    s.summary          = 'A collection of iOS components.'
    s.version          = '1.0.3'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'CoderDoraemon' => '277544354@qq.com' }
    s.homepage         = 'https://github.com/CoderDoraemon/SwiftyExts'
    s.source           = { :git => 'https://github.com/CoderDoraemon/SwiftyExts.git', :tag => s.version.to_s }
    
    s.description      = <<-DESC
    Swift分类扩展：A collection of iOS components SwiftyExts.
    DESC
    
    s.requires_arc = true
    s.swift_version = '5.0'
    s.ios.deployment_target = '8.0'
    s.default_subspec = 'Core'
    
    s.subspec 'Foundation' do |t|
        t.ios.deployment_target = '8.0'
        t.source_files = 'SwiftyExts/Base/Foundation/**/*'
    end
    
    s.subspec 'UIKit' do |t|
        t.ios.deployment_target = '8.0'
        t.source_files = 'SwiftyExts/Base/UIKit/**/*'
    end
    
    s.subspec 'Core' do |t|
        t.ios.deployment_target = '8.0'
        t.dependency 'SwiftyExts/Foundation'
        t.dependency 'SwiftyExts/UIKit'
    end
    
    s.subspec 'Attributes' do |t|
        t.ios.deployment_target = '8.0'
        
        t.source_files = 'SwiftyExts/Attributes/**/*'
        t.dependency 'SwiftyExts/Core'
        t.dependency 'SwiftyAttributes', '>= 5.1.1'
    end
    
    s.subspec 'Device' do |t|
        t.ios.deployment_target = '8.0'
        
        t.source_files = 'SwiftyExts/Device/**/*'
        t.dependency 'SwiftyExts/Core'
        t.dependency 'DeviceKit', '>= 2.3.0'
    end
    
    s.subspec 'All' do |t|
        t.ios.deployment_target = '8.0'
        t.dependency 'SwiftyExts/Core'
        t.dependency 'SwiftyExts/Attributes'
        t.dependency 'SwiftyExts/Device'
    end
    
    s.requires_arc = true
end
