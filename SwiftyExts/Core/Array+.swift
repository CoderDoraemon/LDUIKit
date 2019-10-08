//
//  Array+.swift
//  SwiftExtension
//
//  Created by LDD on 2019/10/7.
//


import Foundation

public func ==<T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
    switch (lhs, rhs) {
    case let (lhs?, rhs?):
        return lhs == rhs
    case (.none, .none):
        return true
    default:
        return false
    }
}

public extension Array {
    
    /// 检查数组是否包含至少一个与给定元素类型相同的项
    func containsType<T>(of element: T) -> Bool {
        let elementType = type(of: element)
        return contains { type(of: $0) == elementType}
    }

    /// 将数组分解为包含第一个元素和其他元素的元组
    func decompose() -> (head: Iterator.Element, tail: SubSequence)? {
        return (count > 0) ? (self[0], self[1..<count]) : nil
    }

    /// 对数组的每个元素及其索引进行迭代。(指数、元素)
    func forEachEnumerated(_ body: @escaping (_ offset: Int, _ element: Element) -> Void) {
        enumerated().forEach(body)
    }

    /// 获取指定索引处的对象(如果它存在)。
    func get(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }

    /// 将对象添加到数组中。
    mutating func insertFirst(_ newElement: Element) {
        insert(newElement, at: 0)
    }

    /// 从数组中返回一个随机元素。
    func random() -> Element? {
        guard count > 0 else { return nil }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }

    /// 反转给定的索引.  i.g.: reverseIndex(2) would be 2 to the last
    func reverseIndex(_ index: Int) -> Int? {
        guard index >= 0 && index < count else { return nil }
        return Swift.max(count - 1 - index, 0)
    }

    /// 将当前数组打乱
    mutating func shuffle() {
        guard count > 1 else { return }
        var j: Int
        for i in 0..<(count-2) {
            j = Int(arc4random_uniform(UInt32(count - i)))
            if i != i+j { self.swapAt(i, i+j) }
        }
    }

    /// 生成一个新的被打乱的数组
    func shuffled() -> Array {
        var result = self
        result.shuffle()
        return result
    }

    /// 返回一个数组，该数组中元素的最大数目为给定的数字。
    func takeMax(_ n: Int) -> Array {
        return Array(self[0..<Swift.max(0, Swift.min(n, count))])
    }

    /// 检查test是否对self中的所有元素返回true
    func testAll(_ body: @escaping (Element) -> Bool) -> Bool {
        return !contains { !body($0) }
    }

    /// 检查数组中的所有元素是真还是假
    func testAll(is condition: Bool) -> Bool {
        return testAll { ($0 as? Bool) ?? !condition == condition }
    }
}

public extension Array where Element: Equatable {

    /// 检查主数组是否包含参数数组
    func contains(_ array: [Element]) -> Bool {
        return array.testAll { self.firstIndex(of: $0) ?? -1 >= 0 }
    }

    /// 检查self是否包含项目列表
    func contains(_ elements: Element...) -> Bool {
        return elements.testAll { self.firstIndex(of: $0) ?? -1 >= 0 }
    }

    /// 返回对象的索引
    func indexes(of element: Element) -> [Int] {
        return enumerated().compactMap { ($0.element == element) ? $0.offset : nil }
    }

    /// 返回对象的最后一个索引
    func lastIndex(of element: Element) -> Int? {
        return indexes(of: element).last
    }

    /// 删除第一个给定对象
    mutating func removeFirst(_ element: Element) {
        guard let index = firstIndex(of: element) else { return }
        self.remove(at: index)
    }

    /// 删除给定对象的所有匹配项，至少需要一个项
    mutating func removeAll(_ firstElement: Element?, _ elements: Element...) {
        var removeAllArr = [Element]()
        
        if let firstElementVal = firstElement {
            removeAllArr.append(firstElementVal)
        }
        
        elements.forEach({element in removeAllArr.append(element)})
        
        removeAll(removeAllArr)
    }

    /// 删除给定对象的所有匹配项
    mutating func removeAll(_ elements: [Element]) {
        // COW ensures no extra copy in case of no removed elements
        self = filter { !elements.contains($0) }
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

    /// Difference of self and the input arrays.
    func difference(_ values: [Element]...) -> [Element] {
        var result = [Element]()
        elements: for element in self {
            for value in values {
                //  if a value is in both self and one of the values arrays
                //  jump to the next iteration of the outer loop
                if value.contains(element) {
                    continue elements
                }
            }
            //  element it's only in self
            result.append(element)
        }
        return result
    }

    /// 交集: Intersection of self and the input arrays.
    func intersection(_ values: [Element]...) -> Array {
        var result = self
        var intersection = Array()

        for (i, value) in values.enumerated() {
            //  the intersection is computed by intersecting a couple per loop:
            //  self n values[0], (self n values[0]) n values[1], ...
            if i > 0 {
                result = intersection
                intersection = Array()
            }

            //  find common elements and save them in first set
            //  to intersect in the next loop
            value.forEach { (item: Element) -> Void in
                if result.contains(item) {
                    intersection.append(item)
                }
            }
        }
        return intersection
    }

    /// 并集: Union of self and the input arrays.
    func union(_ values: [Element]...) -> Array {
        var result = self
        for array in values {
            for value in array {
                if !result.contains(value) {
                    result.append(value)
                }
            }
        }
        return result
    }
    
    /// 返回一个由数组中唯一元素组成的数组
    func unique() -> Array {
        return reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }
}

public extension Array where Element: Hashable {

    /// 删除给定对象的所有匹配项
    mutating func removeAll(_ elements: [Element]) {
        let elementsSet = Set(elements)
        // COW ensures no extra copy in case of no removed elements
        self = filter { !elementsSet.contains($0) }
    }
}

public extension Collection {
    
    /// 如果元素在范围内，则返回指定索引处的元素，否则为nil。
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension Array {
    
    /// 字典转Json
    ///
    /// - Returns: Json字符串
    func toJsonString() -> String {
        
        if self.count == 0 { return "" }
        
        guard JSONSerialization.isValidJSONObject(self) else {
            print("无法解析出, Couldn't parse for \(self)")
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
    
    
}
