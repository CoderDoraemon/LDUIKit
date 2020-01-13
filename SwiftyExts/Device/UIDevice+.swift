//
//  UIDevice+.swift
//  SwiftExtension
//
//  Created by LDD on 2018/10/7.
//

#if os(iOS)
import UIKit
import DeviceKit

let kStatusBarHeight: CGFloat = UIDevice.isiPhoneXSeries ? 44 : 20
let kStatusBarAndNavigationBarHeight: CGFloat = kStatusBarHeight + 44
let kBottomSafeAreaHeight: CGFloat = UIDevice.isiPhoneXSeries ? 34 : 0
let kTabBarHeight: CGFloat = 49.0
let kTabBarSafeAreaHeight: CGFloat = kBottomSafeAreaHeight + kTabBarHeight

public extension UIDevice {
    
    /// iPhone型号描述
    static let model: String = {
        return Device.current.description
    }()
    
    /// 是否是刘海屏
    static let isiPhoneXSeries: Bool = {
        struct Anchor {
            static var result: Bool?
        }
        if let result = Anchor.result {
            return result
        }

        let iPhoneXSeries: [Device] = Device.allXSeriesDevices + Device.allSimulatorXSeriesDevices
        let result: Bool = iPhoneXSeries.contains(Device.current)
        Anchor.result = result
        return result
    }()
    
    /// iPhone6以下版本手机
    static var isiPhone6Below: Bool {
        return (((Device.current.diagonal ) <= 4.7) ? true: false)
    }
}
#endif
