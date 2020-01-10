//
//  CGFloat+Device.swift
//  SwiftExtension
//
//  Created by LDD on 2018/10/7.
//

#if os(iOS)
import CoreGraphics
import UIKit

public extension CGFloat {

    static let statusBarHeight: CGFloat = UIDevice.isiPhoneXSeries ? 44 : 20
    static let statusBarAndNavigationBarHeight: CGFloat = statusBarHeight + navigationBarHeight
    static let bottomSafeAreaHeight: CGFloat = UIDevice.isiPhoneXSeries ? 34 : 0
    static let tabBarHeight: CGFloat = bottomSafeAreaHeight + 55
}
#endif
