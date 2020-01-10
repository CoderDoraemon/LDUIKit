//
//  UIColor+.swift
//  SwiftyExts
//
//  Created by LDD on 2018/3/7.
//

#if canImport(UIKit)
import UIKit
import CoreGraphics

public extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }

    convenience init(gray: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: gray/255, green: gray/255, blue: gray/255, alpha: alpha)
    }

    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        
        guard let hex = Int(formatted, radix: 16) else {
            return nil
        }
        
        let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16) / 255.0)
        let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8) / 255.0)
        let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0) / 255.0)
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    #if canImport(CoreImage)
    func ciColor() -> CIColor {
        return ciColor
    }
    #endif

    func cgColor() -> CGColor {
        return cgColor
    }
}
#endif

