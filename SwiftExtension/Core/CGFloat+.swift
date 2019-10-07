//
//  CGFloat+.swift
//  SwiftExtension
//
//  Created by LDD on 2019/10/7.
//

import CoreGraphics

#if os(iOS)
import UIKit
#endif

public extension CGFloat {
    
    /// 导航栏高度
    static let navigationBarHeight: CGFloat = 44
    
    #if os(iOS)
    /// 屏幕宽度
    static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    /// 屏幕高度
    static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    /// 屏幕
    static let screenMinEdge: CGFloat = Swift.min(screenWidth, screenHeight)
    /// 状态栏高度
    static let statusBarHeight: CGFloat = UIDevice.isiPhoneXSeries ? 44 : 20
    /// 状态栏+导航栏高度
    static let statusBarAndNavigationBarHeight: CGFloat = statusBarHeight + navigationBarHeight
    /// 屏幕底部安全高度
    static let bottomSafeAreaHeight: CGFloat = UIDevice.isiPhoneXSeries ? 34 : 0
    /// TabBar高度
    static let tabBarHeight: CGFloat = bottomSafeAreaHeight + 55
    #endif


    
}
