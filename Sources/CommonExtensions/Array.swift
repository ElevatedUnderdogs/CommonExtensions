//
//  Array.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension Array where Element: Hashable {

    /// Big O(N) version.
    var uniques: Array {
        // Go front to back, add element to buffer if it isn't a repeat.
         var buffer: [Element] = []
         var dictionary: [Element: Int] = [:]
         for element in self where dictionary[element] == nil {
             buffer.append(element)
             dictionary[element] = 1
         }
         return buffer
    }

    var set: Set<Element> {
        Set(self)
    }
}

public extension Array where Element: Hashable & Equatable {

    var uniqueOrdered: [Element] {
        var buffer: [Element] = []
        var added = Set<Element>()
        for element in self where !added.contains(element) {
            added.insert(element)
            buffer.append(element)
        }
        return buffer
    }
}


infix operator ???

public extension Array {

    mutating func removeLastSafe() -> Element? {
        print("The count is: \(count)")
        if count > 0 {
            return removeLast()
        }
        return nil
    }

    func noNils<T>() -> Bool where Element == T? {
        allSatisfy { $0 != nil }
    }

    var secondToLast: Element? {
        let target: Index = count - 2
        return indices.contains(target) ? self[target] : nil
    }

    var hasElements: Bool {
        !isEmpty
    }

    // MARK - access

    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }


    // MARK - mutating

    mutating func pullFirst() -> Element? {
        if isEmpty { return nil }
        return removeFirst()
    }

    mutating func swap(last: Int = 0, for element: Element) {
        if count == 0 {
            self = [element]
            return
        }
        for  _ in 0...last  {
            _ = popLast()
        }
        append(element)
    }

    // MARK - computed

    var data: Data {
        return self.withUnsafeBufferPointer { pointer in
            return Data(buffer: pointer)
        }
    }

    var lastIndex: Int {
        return count - 1
    }

    ///Returns the second value when empty
    static func ???(lhs: Array, rhs: Array) -> Array {
        if lhs.isEmpty {
            return rhs
        } else {
            return lhs
        }
    }
}


public extension Array where Element == Any {

    var asText: String {
        var texts: String = ""
        for element in self {
            texts.append(String(describing: element) + "\n" + "-".times(30).joined() + "\n")
        }
        return texts
    }

    static func permutate<A, B>(
        first: [A],
        second: [B]
    ) -> [(A, B)] {
        var matrix: [(A, B)] = []
        for fItem in first {
            for sItem in second {
                matrix.append((fItem, sItem))
            }
        }
        return matrix
    }
}


public extension Array where Element: Equatable {

    mutating func remove(_ element: Element) {
        if !self.contains(element) { return }
        self = self.filter { $0 != element }
    }

    mutating func appendIfUnique(_ element: Element) {
        if !contains(element) {
            append(element)
        }
    }

    mutating func appendUnique(contentsOf contents: [Element]) {
        for element in contents {
            self.appendIfUnique(element)
        }
    }

    mutating func remove(element: Element) {
        if let index = firstIndex(of: element) {
            remove(at: index)
        }
    }
}

public extension Array where Element == Int {
    var strings: [String] {
        return map { String($0) }
    }
}

public extension Array where Element == [String] {


    var asCSV: String? {
        let initial: [[String]] = map { row in /// Get all the rows
            row.map { /// Return all rows with replaced values.
                $0.replacingOccurrences(of: ",", with: "_")
            }
        }
        /// Convert each row into a csvCommaSeparatedNew  string.
        var str = initial.map(\.csvCommaSeparatedNewLine)
            .joined()
        guard !str.isEmpty else { return nil }
        str.removeLast()
        return str
    }
}



public extension Array where Element == String {

    var csvCommaSeparatedNewLine: String {
        joined(separator: ",") + "\n"
    }

    ///  This will shift the values of an array while maintaining the same number of elements.
    ///
    /// - Parameters:
    ///     - offset: offset 0 has no affect, offset n knocks off the last n element and appends n empty value element to the front. When the offset is negative n it removes n elements from the front and appends n elements to the back.
    ///     - emptyValue: the empty value to append.
    /// - Returns:
    ///      - the newly modified array equal to self.
    @discardableResult
    mutating func shift(_ offset: Int, emptyValue: String = "nil") -> Self {
        if offset > 0 {
            removeLast(offset)
            self = Array(repeating: emptyValue, count: offset) + self
        } else if offset < 0 {
            let magnitude = abs(offset)
            removeFirst(magnitude)
            self = self + Array(repeating: emptyValue, count: magnitude)
        }
        return self
    }

    ///  This will shift the values of an array while maintaining the same number of elements.
    ///
    /// - Parameters:
    ///     - offset: offset 0 has no affect, offset n knocks off the last n element and appends n empty value element to the front. When the offset is negative n it removes n elements from the front and appends n elements to the back.
    ///     - emptyValue: the empty value to append.
    /// - Returns:
    ///      - the newly modified array equal to self.
    func shifted(_ offset: Int, emptyValue: String = "nil") -> Self {
        if offset > 0 {
            var new = self
            assert(count > offset, "The array has too few elements: \(new), perhaps the api is unexpectedly stingy with results?")
            new.removeLast(offset)
            return Array(repeating: emptyValue, count: offset) + new
        } else if offset < 0 {
            let magnitude = abs(offset)
            var new = self
            new.removeFirst(magnitude)
            return new + Array(repeating: emptyValue, count: magnitude)
        } else {
            return self
        }
    }

    var asString: String {
        var string = ""
        for element in self {
            string.append(" " + element)
        }
        return string
    }
}

public extension Array where Element == Date {

    init(
        between first: Date,
        and second: Date,
        timeInterval: TimeInterval//,
       // autoIncludesSecondDate: Bool
    ) {
        self = [first]
        var first: Date = first.addingTimeInterval(timeInterval)
        while first <= second {
            append(first)
            first = first.addingTimeInterval(timeInterval)
        }
    }
}

public extension Array where Element == Array<String> {
    var removeNils: Self {
        filter { row in
            row.allSatisfy { cell in
                cell != "nil" && cell != "NIL" && cell != "Nil"
            }
        }
    }
}


public extension Array where Element == Decimal? {

    func fromLast(_ indexOffset: Int?) -> Element {
        guard let indexOffset = indexOffset else { return .zero }
        return self[safe: count - 1 - indexOffset] ?? .zero
    }
}
