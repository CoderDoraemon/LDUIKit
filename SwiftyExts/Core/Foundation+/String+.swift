//
//  String+.swift
//  SwiftyExts
//
//  Created by LDD on 2018/3/7.
//

import Foundation
import CoreGraphics

public extension String {

    var attributedString: NSAttributedString {
        return NSAttributedString(string: self)
    }

    var mutableAttributedString: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }

    var nsString: NSString {
        return self as NSString
    }
    
    /// 字符串转CGFloat
    ///
    /// - Returns: CGFloat
    func toCGFloat() -> CGFloat {
        guard let n = NumberFormatter().number(from: self) else {
            return 0
        }
        return CGFloat(n.floatValue)
    }
    
    /// 字符串转Float
    ///
    /// - Returns: Float
    func toFloat() -> Float {
        guard let n = NumberFormatter().number(from: self) else {
            return 0
        }
        return n.floatValue
    }
    
    /// 字符串转Int
    ///
    /// - Returns: Int
    func toInt() -> Int {
        guard let n = NumberFormatter().number(from: self) else {
            return 0
        }
        return n.intValue
    }
    
    /// 字符串转TimeInterval
    ///
    /// - Returns: TimeInterval
    func toTimeInterval() -> TimeInterval {
        guard let n = NumberFormatter().number(from: self) else {
            return 0
        }
        return TimeInterval(n.intValue)
    }
    
    /// 字符串转Double
    ///
    /// - Returns: Double
    func toDouble() -> Double {
        guard let n = NumberFormatter().number(from: self) else {
            return 0
        }
        return n.doubleValue
    }
}

public extension String {

    var clean: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    func replace(_ string: String, with: String, options: String.CompareOptions = [], range: Range<String.Index>? = nil) -> String {
        return replacingOccurrences(of: string, with: with, options: options, range: range)
    }

    func replacePrefix(string: String, with: String) -> String {
        if self.hasPrefix(string) {
            return with + String(self.dropFirst(string.count))
        }
        return self
    }

    func replaceSuffix(string: String, with: String) -> String {
        if self.hasSuffix(string) {
            return "\(self.dropLast(string.count))" + with
        }
        return self
    }

    func remove(string: String) -> String {
        return self.replace(string, with: "")
    }

    func removePrefix(string: String) -> String {
        return self.replacePrefix(string: string, with: "")
    }

    func removeSuffix(string: String) -> String {
        return self.replaceSuffix(string: string, with: "")
    }

    func i18n(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }

    static func random(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)

        var randomString = ""
        for _ in 0 ..< length {
            let rand: UInt32 = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }

    func dictionary(using: String.Encoding = String.Encoding.utf8) -> Any? {
        if let data = self.data(using: using) {
            do {
                return try JSONSerialization.jsonObject(
                    with: data, options: JSONSerialization.ReadingOptions.allowFragments
                )
            } catch {
                printLog("JSONSerialization.jsonObject() Error!")
            }
        }
        return nil
    }
}

public extension String {
    var url: URL? {
        
        guard let urlStr = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        
        return URL(string: urlStr)
    }
}

public extension String {
    
    var length: Int {
        return self.count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)), upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
}
