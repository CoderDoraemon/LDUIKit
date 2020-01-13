//
//  UIApplication+.swift
//  SwiftyExts
//
//  Created by LDD on 2018/3/7.
//

#if canImport(UIKit)
import UIKit

public extension UIApplication {
    
    var topViewController: UIViewController? {
        guard var topViewController = UIApplication.shared.keyWindow?.rootViewController else { return nil }

        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        return topViewController
    }


    var topNavigationController: UINavigationController? {
        return topViewController as? UINavigationController
    }
    
    var currentWindow: UIWindow? {
        
        // 找到当前显示的UIWindow
        var window: UIWindow? = keyWindow
        /**
         window有一个属性：windowLevel
         当 windowLevel == UIWindowLevelNormal 的时候，表示这个window是当前屏幕正在显示的window
         */
        if window?.windowLevel != UIWindow.Level.normal {
            
            for tempWindow in UIApplication.shared.windows {
                
                if tempWindow.windowLevel == UIWindow.Level.normal {
                    
                    window = tempWindow
                    break
                }
            }
        }
        
        return window
        
    }
}
#endif
