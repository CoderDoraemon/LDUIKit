//
//  NSInteger+.swift
//  SwiftyExts
//
//  Created by LDD on 2018/3/7.
//

import UIKit

public extension NSInteger {
    
    /// 转CGFloat
    ///
    /// - Returns: CGFloat
    func toCGFloat() -> CGFloat {
        
        return CGFloat(self)
    }
    /// 转Float
    ///
    /// - Returns: Float
    func toFloat() -> Float {
        return Float(self)
    }
    /// 转Double
    ///
    /// - Returns: Double
    func toDouble() -> Double {
        return Double(self)
    }
}
