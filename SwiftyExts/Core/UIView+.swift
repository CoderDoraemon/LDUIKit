//
//  UIView+.swift
//  SwiftyExts
//
//  Created by LDD on 2019/10/7.
//

#if canImport(UIKit)
import UIKit

// MARK: Frame Extensions
public extension UIView {
    
    /// 添加子控件
    /// - Parameter views: 子控件数组
    func addSubviews(_ views: [UIView]) {
        views.forEach { [weak self] eachView in
            self?.addSubview(eachView)
        }
    }
    
    /// 子控件布局完成获取当前View的尺寸
    func resizeToFitSubviews() {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            let newWidth = aView.x + aView.w
            let newHeight = aView.y + aView.h
            width = max(width, newWidth)
            height = max(height, newHeight)
        }
        frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    /// 子控件布局完成获取当前View的尺寸
    /// - Parameter tagsToIgnore: 忽略哪些子控件不参与尺寸计算
    func resizeToFitSubviews(_ tagsToIgnore: [Int]) {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            if !tagsToIgnore.contains(someView.tag) {
                let newWidth = aView.x + aView.w
                let newHeight = aView.y + aView.h
                width = max(width, newWidth)
                height = max(height, newHeight)
            }
        }
        frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    /// 调整此视图的大小以适应其宽度。
    func resizeToFitWidth() {
        let currentHeight = self.h
        self.sizeToFit()
        self.h = currentHeight
    }
    
    /// 调整此视图的大小以适应其高度。
    func resizeToFitHeight() {
        let currentWidth = self.w
        self.sizeToFit()
        self.w = currentWidth
    }

    /// x
    var x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame = CGRect(x: value, y: self.y, width: self.w, height: self.h)
        }
    }

    /// y
    var y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame = CGRect(x: self.x, y: value, width: self.w, height: self.h)
        }
    }

    /// w
    var w: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: value, height: self.h)
        }
    }

    /// h
    var h: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: self.w, height: value)
        }
    }

    /// 左 = x
    var left: CGFloat {
        get {
            return self.x
        } set(value) {
            self.x = value
        }
    }

    /// 右 = x + w
    var right: CGFloat {
        get {
            return self.x + self.w
        } set(value) {
            self.x = value - self.w
        }
    }

    /// 上 = y
    var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }

    /// 下 = y + h
    var bottom: CGFloat {
        get {
            return self.y + self.h
        } set(value) {
            self.y = value - self.h
        }
    }

    /// origin
    var origin: CGPoint {
        get {
            return self.frame.origin
        } set(value) {
            self.frame = CGRect(origin: value, size: self.frame.size)
        }
    }

    /// centerX
    var centerX: CGFloat {
        get {
            return self.center.x
        } set(value) {
            self.center.x = value
        }
    }

    /// centerY
    var centerY: CGFloat {
        get {
            return self.center.y
        } set(value) {
            self.center.y = value
        }
    }

    /// size
    var size: CGSize {
        get {
            return self.frame.size
        } set(value) {
            self.frame = CGRect(origin: self.frame.origin, size: value)
        }
    }

    /// EZSE: getter for an leftwards offset position from the leftmost edge.
    func leftOffset(_ offset: CGFloat) -> CGFloat {
        return self.left - offset
    }

    /// EZSE: getter for an rightwards offset position from the rightmost edge.
    func rightOffset(_ offset: CGFloat) -> CGFloat {
        return self.right + offset
    }

    /// EZSE: aligns the view to the top by a given offset.
    func topOffset(_ offset: CGFloat) -> CGFloat {
        return self.top - offset
    }

    /// EZSE: align the view to the bottom by a given offset.
    func bottomOffset(_ offset: CGFloat) -> CGFloat {
        return self.bottom + offset
    }

    //TODO: Add to readme
    /// EZSE: align the view widthwise to the right by a given offset.
    func alignRight(_ offset: CGFloat) -> CGFloat {
        return self.w - offset
    }

    /// SwiftyExts
    func reorderSubViews(_ reorder: Bool = false, tagsToIgnore: [Int] = []) -> CGFloat {
        var currentHeight: CGFloat = 0
        for someView in subviews {
            if !tagsToIgnore.contains(someView.tag) && !(someView ).isHidden {
                if reorder {
                    let aView = someView
                    aView.frame = CGRect(x: aView.frame.origin.x, y: currentHeight, width: aView.frame.width, height: aView.frame.height)
                }
                currentHeight += someView.frame.height
            }
        }
        return currentHeight
    }
    
    /// 移除所有子控件
    func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }

    /// 在父视图中水平居中视图
    func centerXInSuperView() {
        guard let parentView = superview else {
            assertionFailure("SwiftyExts Error: The view \(self) doesn't have a superview")
            return
        }

        self.x = parentView.w/2 - self.w/2
    }

    /// 在父视图中垂直居中视图
    func centerYInSuperView() {
        guard let parentView = superview else {
            assertionFailure("SwiftyExts Error: The view \(self) doesn't have a superview")
            return
        }

        self.y = parentView.h/2 - self.h/2
    }

    /// 中心视图在父视图水平和垂直
    func centerInSuperView() {
        self.centerXInSuperView()
        self.centerYInSuperView()
    }
    
    /// 转图片
    func toImage () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

// MARK: 初始化
public extension UIView {
    
    @objc convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
    }

    /// 在视图周围放置填充
    convenience init(superView: UIView, padding: CGFloat) {
        self.init(frame: CGRect(x: superView.x + padding, y: superView.y + padding, width: superView.w - padding*2, height: superView.h - padding*2))
    }

    /// 复制父视图的大小
    convenience init(superView: UIView) {
        self.init(frame: CGRect(origin: CGPoint.zero, size: superView.size))
    }
}

// MARK: Layer Extensions
extension UIView {
    
    /// 设置圆角
    func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    /// 设置阴影
    /// - Parameter offset: 偏移量
    /// - Parameter radius: 阴影半径
    /// - Parameter color: 阴影颜色
    /// - Parameter opacity: 透明值
    /// - Parameter cornerRadius: 路径圆角
    func addShadow(offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float, cornerRadius: CGFloat? = nil) {
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
    }
    
    /// 添加边框
    /// - Parameter width: 边框宽度
    /// - Parameter color: 边框颜色
    func addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }
    
    /// 添加上边框
    /// - Parameter size: 尺寸
    /// - Parameter color: 颜色
    func addBorderTop(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }
    
    /// 添加下边框
    /// - Parameter size: 尺寸
    /// - Parameter color: 颜色
    func addBorderBottom(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: frame.height - size, width: frame.width, height: size, color: color)
    }

    /// 添加左边框
    /// - Parameter size: 尺寸
    /// - Parameter color: 颜色
    public func addBorderLeft(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: size, height: frame.height, color: color)
    }
    
    /// 添加右边框
    /// - Parameter size: 尺寸
    /// - Parameter color: 颜色
    public func addBorderRight(size: CGFloat, color: UIColor) {
        addBorderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color)
    }
    
    /// 高性能添加边框
    /// - Parameter size: 尺寸
    /// - Parameter color: 颜色
    /// - Parameter padding: 内边距
    func addBorderTopWithPadding(size: CGFloat, color: UIColor, padding: CGFloat) {
        addBorderUtility(x: padding, y: 0, width: frame.width - padding*2, height: size, color: color)
    }
    
    /// 绘制圆角
    func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.w, height: self.w), cornerRadius: self.w/2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
    }
    
    /// 绘制线条
    public func drawStroke(width: CGFloat, color: UIColor) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.w, height: self.w), cornerRadius: self.w/2)
        let shapeLayer = CAShapeLayer ()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        self.layer.addSublayer(shapeLayer)
    }
}

// MARK: 高性能
public extension UIView {
    
    
    /// 绘制圆角（确定Frame）
    /// - Parameter corners: 方向
    /// - Parameter radius: 半径
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    /// 带圆形/胶囊盖的掩模正方形/长方形UIView，其周围有所需颜色和宽度的边框
    func roundView(withBorderColor color: UIColor? = nil, withBorderWidth width: CGFloat? = nil) {
        self.setCornerRadius(radius: min(self.frame.size.height, self.frame.size.width) / 2)
        self.layer.borderWidth = width ?? 0
        self.layer.borderColor = color?.cgColor ?? UIColor.clear.cgColor
    }
    
    /// 移除UIView周围的所有遮罩
    func nakedView() {
        self.layer.mask = nil
        self.layer.borderWidth = 0
    }
}


// MARK: Fade Extensions
public let UIViewDefaultFadeDuration: TimeInterval = 0.4
public extension UIView {
    /// 淡入与持续时间，延迟和完成块。
    func fadeIn(_ duration: TimeInterval? = UIViewDefaultFadeDuration, delay: TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        fadeTo(1.0, duration: duration, delay: delay, completion: completion)
    }

    /// 淡出与持续时间，延迟和完成块。
    func fadeOut(_ duration: TimeInterval? = UIViewDefaultFadeDuration, delay: TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        fadeTo(0.0, duration: duration, delay: delay, completion: completion)
    }

    /// 淡入特定值与持续时间，延迟和完成块。
    func fadeTo(_ value: CGFloat, duration: TimeInterval? = UIViewDefaultFadeDuration, delay: TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration ?? UIViewDefaultFadeDuration, delay: delay ?? UIViewDefaultFadeDuration, options: .curveEaseInOut, animations: {
            self.alpha = value
        }, completion: completion)
    }
}

fileprivate extension UIView {
    
    /// 添加边框
    func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
}

#endif
