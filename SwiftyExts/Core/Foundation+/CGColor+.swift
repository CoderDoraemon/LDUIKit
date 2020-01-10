//
//  CGColor+.swift
//  SwiftyExts
//
//  Created by LDD on 2018/3/7.
//

import CoreGraphics

#if canImport(CoreImage)
import CoreImage
#endif

#if canImport(UIKit)
import UIKit
#endif

public extension CGColor {

    #if canImport(CoreImage)
    func ciColor() -> CIColor {
        return CIColor(cgColor: self)
    }
    #endif

    #if canImport(UIKit)
    func uiColor() -> UIColor {
        return UIColor(cgColor: self)
    }
    #endif
}
