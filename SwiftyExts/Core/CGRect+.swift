//
//  CGRect+.swift
//  SwiftyExts
//
//  Created by LDD on 2019/10/7.
//

import CoreGraphics

public extension CGRect {
    
    var x: CGFloat {
        get {
            return self.origin.x
        }
        set {
            var r = self
            r.origin.x = newValue
            self = r
        }
    }
    
    var y: CGFloat {
        get {
            return self.origin.y
        }
        set {
            var r = self
            r.origin.y = newValue
            self = r
        }
    }
}

