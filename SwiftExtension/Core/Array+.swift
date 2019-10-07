//
//  Array+.swift
//  SwiftExtension
//
//  Created by LDD on 2019/10/7.
//


import Foundation

public extension Array where Element: Equatable {

    mutating func removeFirst(_ value: Element) {
        if let index = firstIndex(of: value) {
            remove(at: index)
        }
    }

    mutating func removeAll(_ value: Element) {
        removeAll { element -> Bool in
            return value == element
        }
    }
}
