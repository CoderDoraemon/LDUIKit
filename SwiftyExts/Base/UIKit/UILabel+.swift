//
//  UILabel+.swift
//  SwiftyExts
//
//  Created by LDD on 2018/3/8.
//

#if os(iOS) || os(tvOS)

import UIKit

public extension UILabel {
    
    /// 初始化
    /// - Parameter font: 字体
    /// - Parameter color: 颜色
    /// - Parameter alignment: 对齐方式
    convenience init(font: UIFont, color: UIColor, alignment: NSTextAlignment) {
        self.init()
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
    }

    /// 初始化
    /// - Parameter x: x
    /// - Parameter y: y
    /// - Parameter w: w
    /// - Parameter h: h
    /// - Parameter fontSize: 字体大小
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, fontSize: CGFloat = 17) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        font = UIFont.systemFont(ofSize: fontSize)
        backgroundColor = UIColor.clear
        clipsToBounds = true
        textAlignment = NSTextAlignment.left
        isUserInteractionEnabled = true
        numberOfLines = 1
    }

    /// 获取尺寸
    func getEstimatedSize(_ width: CGFloat = CGFloat.greatestFiniteMagnitude, height: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        return sizeThatFits(CGSize(width: width, height: height))
    }

    /// 获取高度
    func getEstimatedHeight() -> CGFloat {
        return sizeThatFits(CGSize(width: w, height: CGFloat.greatestFiniteMagnitude)).height
    }

    /// 获取宽度
    func getEstimatedWidth() -> CGFloat {
        return sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: h)).width
    }

    /// 设置高度
    func fitHeight() {
        self.h = getEstimatedHeight()
    }

    /// 设置高度
    func fitWidth() {
        self.w = getEstimatedWidth()
    }

    /// 设置宽高
    func fitSize() {
        self.fitWidth()
        self.fitHeight()
        sizeToFit()
    }
    
    /// 设置text
    func set(text _text: String?, duration: TimeInterval) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: { () -> Void in
            self.text = _text
        }, completion: nil)
    }
}


#endif
