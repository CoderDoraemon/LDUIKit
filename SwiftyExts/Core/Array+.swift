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
    
    @discardableResult
    mutating func remove(_ element: Element) -> Index? {
        guard let index = firstIndex(of: element) else { return nil }
        remove(at: index)
        return index
    }

    @discardableResult
    mutating func remove(_ elements: [Element]) -> [Index] {
        return elements.compactMap { remove($0) }
    }
}

extension Array {
    
    func shuffle() -> Array {
        var list = self
        for index in 0..<list.count {
            let newIndex = Int(arc4random_uniform(UInt32(list.count-index))) + index
            if index != newIndex {
                list.swapAt(index, newIndex)
            }
        }
        return list
    }
    
    /// 字典转json
    ///
    /// - Returns: json字符串
    func toJSONString() -> String {
        
        if self.count == 0 { return "" }
        
        guard JSONSerialization.isValidJSONObject(self) else {
            print("无法解析出JSONString")
            return ""
        }
        
        guard JSONSerialization.isValidJSONObject(self) else {
            print("无法解析出JSONString")
            return ""
        }
        
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []),
            let json = String(data: data, encoding: .utf8) else {
                return ""
        }
        
        return json
    }
    
    /// 根据数组计算collectionview的内容高度
    ///
    /// - Parameters:
    ///   - itemHeight: cell 高度
    ///   - itemSpace: 上下间距
    ///   - horizontalNum: 水平方向的 Item 个数
    /// - Returns: 返回内容高度
    func countCollectionViewHeight(itemHeight: CGFloat, itemSpace: CGFloat, horizontalNum: Int, countMaxNum: Int) -> CGFloat {
        
        var row = 0
        
        let total = Swift.min(countMaxNum, self.count)
        
        if total % horizontalNum == 0 {
            row = total / horizontalNum
        } else {
            row = total / horizontalNum + 1
        }
        
        var height = CGFloat(row) * itemHeight
        
        height += itemSpace * CGFloat(total / horizontalNum)
        
        return height
    }
    
    func safeObjcAtIndex(_ index: Int) -> Element? {
        if index < self.count {
            return self[index]
        } else {
            return nil
        }
    }
    
    /// 去重
    ///
    /// - Parameter filter: 过滤条件
    /// - Returns: 去重后的数组
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        
        var result = [Element]()
        for value in self {
            //调用filter，获得需要用来判断的属性E
            let key = filter(value)
            //此处利用map函数 来将value类型数组转换成E类型的数组，以此来判断
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
    
    /// 将重复的全部删除掉
    ///
    /// - Parameter filter: 过滤条件
    /// - Returns: 去重后的数组
    func filterDifferents<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            } else {
                if let index = result.map({filter($0)}).firstIndex(of: key) {
                    result.remove(at: index)
                }
            }
        }
        return result
    }
}

public extension Collection {
    subscript(safe index: Index) -> Element? {
        return startIndex <= index && index < endIndex ? self[index] : nil
    }
}
