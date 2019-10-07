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

    #if os(iOS)
    static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    static let screenMinEdge: CGFloat = Swift.min(screenWidth, screenHeight)
    #endif

    static let navigationBarHeight: CGFloat = 44
}
