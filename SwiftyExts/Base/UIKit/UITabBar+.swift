//
//  UITabBar+.swift
//  SwiftyExts
//
//  Created by LDD on 2018/3/8.
//

import UIKit

fileprivate let pointWidth = 10.0
fileprivate let constantIdentify = 999

public extension UITabBar {
    
    
    /// TabBar加小红点
    /// - Parameter index: TabBar索引
    func showBadge(_ index: Int = 0) {
        
        guard let num = self.items?.count, num > 0, index < num else { return }
        
        removeBadge(index)
        
        let badgeView = UIView()
        badgeView.tag = constantIdentify + index
        
        badgeView.layer.cornerRadius = CGFloat(pointWidth * 0.5)
        badgeView.backgroundColor = UIColor.red
        let tabFrame = self.frame
        
        let percentX = (Double(index) + 0.6) / Double(num)
        let x = ceil(Double(percentX) * Double(tabFrame.size.width))
        let y = ceil(0.1 * tabFrame.size.height)
        badgeView.frame = CGRect(x: x, y: Double(y), width: pointWidth, height: pointWidth)
        
        self.addSubview(badgeView)
    }
    
    /// 隐藏TabBar小红点
    /// - Parameter index: 索引
    func hideBadge(_ index: Int = 0) {
        removeBadge(index)
    }
    
    /// 移除TabBar小红点
    /// - Parameter index: 索引
    fileprivate func removeBadge(_ index: Int = 0) {
        for view in subviews {
            if view.tag == (constantIdentify + index) {
                view.removeFromSuperview()
            }
        }
    }
}

