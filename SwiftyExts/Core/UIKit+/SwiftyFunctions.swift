//
//  SwiftyFunctions.swift
//  SwiftyExts
//
//  Created by LDD on 2018/3/8.
//

import UIKit

public struct sf {
    
    /// 返回应用程序的名字
    static var appDisplayName: String? {
        if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return bundleDisplayName
        } else if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            return bundleName
        }

        return nil
    }

    /// 返回应用程序的版本号
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    /// 返回应用程序的构建号
    static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }

    /// 返回app的bundle ID
    static var appBundleID: String? {
        return Bundle.main.bundleIdentifier
    }

    /// 返回应用程序的版本和构建号“v0.3(7)”
    static var appVersionAndBuild: String? {
        if appVersion != nil && appBuild != nil {
            if appVersion == appBuild {
                return "v\(appVersion!)"
            } else {
                return "v\(appVersion!)(\(appBuild!))"
            }
        }
        return nil
    }

    /// 是否是Debug模式
    static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }

    /// 是否是Release模式
    static var isRelease: Bool {
        #if DEBUG
        return false
        #else
        return true
        #endif
    }

    ///是否是模拟器
    static var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    #if os(iOS)

    /// 返回当前屏幕方向
    static var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }

    #endif
    
    #if os(iOS) || os(tvOS)

    /// 返回屏幕宽度
    static var screenWidth: CGFloat {

        #if os(iOS)

        if screenOrientation.isPortrait {
            return UIScreen.main.bounds.size.width
        } else {
            return UIScreen.main.bounds.size.height
        }

        #elseif os(tvOS)

        return UIScreen.main.bounds.size.width

        #endif
    }

    /// 返回屏幕高度
    static var screenHeight: CGFloat {

        #if os(iOS)

        if screenOrientation.isPortrait {
            return UIScreen.main.bounds.size.height
        } else {
            return UIScreen.main.bounds.size.width
        }

        #elseif os(tvOS)

            return UIScreen.main.bounds.size.height

        #endif
    }
    
    #endif

    #if os(iOS)

    /// 返回状态栏的高度
    static var screenStatusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }

    /// 返回屏幕的高度没有状态栏
    static var screenHeightWithoutStatusBar: CGFloat {
        if screenOrientation.isPortrait {
            return UIScreen.main.bounds.size.height - screenStatusBarHeight
        } else {
            return UIScreen.main.bounds.size.width - screenStatusBarHeight
        }
    }
    
    

    #endif
}

public extension sf {
    
    /* 递归找最上面的viewController */
    static func topViewController() -> UIViewController? {
        
        return self.topViewControllerWithRootViewController(viewController: self.getCurrentWindow()?.rootViewController)
    }
    
    fileprivate static func topViewControllerWithRootViewController(viewController :UIViewController?) -> UIViewController? {
        
        if viewController == nil {
            
            return nil
        }
        
        if viewController?.presentedViewController != nil {
            
            return self.topViewControllerWithRootViewController(viewController: viewController?.presentedViewController!)
        }
        else if viewController?.isKind(of: UITabBarController.self) == true {
            
            return self.topViewControllerWithRootViewController(viewController: (viewController as! UITabBarController).selectedViewController)
        }
        else if viewController?.isKind(of: UINavigationController.self) == true {
            
            return self.topViewControllerWithRootViewController(viewController: (viewController as! UINavigationController).visibleViewController)
        }
        else {
            
            return viewController
        }
    }
    
    // 找到当前显示的window
    fileprivate static func getCurrentWindow() -> UIWindow? {
        
        // 找到当前显示的UIWindow
        var window: UIWindow? = UIApplication.shared.keyWindow
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

public struct Asyncs {
    
    /// GCD异步线程
    ///
    /// - Parameters:
    ///   - qos: 异步线程优先级
    ///   - globalTask: 子线程
    ///   - mainTask: 主线程
    static func async(qos: DispatchQoS.QoSClass? = nil, globalTask: @escaping () -> Void, mainTask: (() -> Void)? = nil) {
        
        let item = DispatchWorkItem(block: globalTask)
        
        if let qos = qos {
            DispatchQueue.global(qos: qos).async(execute: item)
        } else {
            DispatchQueue.global().async(execute: item)
        }
        
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
    }
    
    /// GCD主线程延迟
    ///
    /// - Parameters:
    ///   - seconds: 延迟秒数
    ///   - block: 主线程回调
    /// - Returns: DispatchWorkItem任务
    @discardableResult
    static func delay(_ seconds: Double, _ block: @escaping () -> ()) -> DispatchWorkItem {
        
        let item = DispatchWorkItem(block: block)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds, execute: item)
        return item
    }
    
    /// GCD异步线程延迟
    ///
    /// - Parameters:
    ///   - seconds: 延迟秒数
    ///   - qos: 异步线程优先级
    ///   - globalTask: 子线程
    ///   - mainTask: 主线程
    /// - Returns: DispatchWorkItem任务
    @discardableResult
    static func delay(_ seconds: Double, qos: DispatchQoS.QoSClass? = nil, globalTask: @escaping () -> Void, mainTask: (() -> Void)? = nil) -> DispatchWorkItem {
        
        let item = DispatchWorkItem(block: globalTask)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds, execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
        
        return item
    }
}

