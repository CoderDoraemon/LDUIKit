//
//  CIColor+.swift
//  SwiftyExts
//
//  Created by LDD on 2019/10/7.
//

#if canImport(CoreImage)
import CoreImage

#if canImport(UIKit)
import UIKit
#endif

public extension CIColor {

    #if canImport(UIKit)
    func uiColor() -> UIColor {
        return UIColor(ciColor: self)
    }
    
    func cgColor() -> CGColor {
        return CGColor(colorSpace: colorSpace, components: components) ?? uiColor().cgColor()
    }
    #else
    func cgColor() -> CGColor? {
        return CGColor(colorSpace: colorSpace, components: components)
    }
    #endif
}
#endif

