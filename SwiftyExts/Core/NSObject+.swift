//
//  NSObject+.swift
//  SwiftyExts
//
//  Created by LDD on 2019/10/7.
//

import Foundation
import UIKit

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        String(describing: self)
    }

    var className: String {
        Self.className
    }
}

extension NSObject: ClassNameProtocol {}

public extension NSObjectProtocol {
    var describedProperty: String {
        let mirror = Mirror(reflecting: self)
        return mirror.children.map { element -> String in
            let key = element.label ?? "Unknown"
            let value = element.value
            return "\(key): \(value)"
            }
            .joined(separator: "\n")
    }
}



extension NSObject {
    
    func showClsRuntime() {
        print("Start methodlist")
        var methodNum: UInt32 = 0
        if let methodList = class_copyMethodList(self.classForCoder, &methodNum) {
            
            for index in 0..<numericCast(methodNum) {
                let method: Method = methodList[index]
                if let encodMethod = method_getTypeEncoding(method) {
                    print(String.init(utf8String: encodMethod) ?? "")
                }
                
                print(String.init(utf8String: method_copyReturnType(method)) ?? "")
                let methodName = method_getName(method)
                print(methodName.description)
            }
        }
        print("End methodlist")
        
        print("Start propertylist")
        var propertyNum: UInt32 = 0
        if let propertyList = class_copyPropertyList(self.classForCoder, &propertyNum) {
            for index in 0..<numericCast(propertyNum) {
                let property: objc_property_t = propertyList[index]
                
                let propertyName = property_getName(property)
                print(String(utf8String: propertyName) ?? "")
                
                if let propertryAttribute = property_getAttributes(property) {
                    print(String.init(utf8String: propertryAttribute) ?? "")
                }
            }
        }
        print("End propertylist")
    }
}

