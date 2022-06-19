//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension Sequence where Element: StringProtocol {
    func searched(text: String?) -> [Element] {
        filter { $0.containsOrEmpty(other: text) }
    }
}

public extension Sequence where Element: CustomStringConvertible {
    func searched(text: String?) -> [Element] {
        filter { $0.description.containsOrEmpty(other: text) }
    }
}

public extension Sequence where Element == UInt8 {
    var data: Data { .init(self) }
}

public extension Sequence {

    var array: [Element] {
        Array(self)
    }

    func min<T: Comparable>(_ predicate: (Element) -> T)  -> Element? {
        self.min(by: { predicate($0) < predicate($1) })
    }
    /// Returns the element which has the highest value.
    func maximum<T: Comparable>(_ predicate: (Element) -> T)  -> Element? {
        self.max(by: { predicate($0) < predicate($1) })
    }

    func maxProperty<T: Comparable>(_ predicate: (Element) -> T)  -> T? {
        self.max(by: { predicate($0) < predicate($1) }).map { predicate($0) }
    }

    func sorted<T: Comparable>(_ predicate: (Element) -> T, by areInIncreasingOrder: ((T, T)-> Bool) = (<)) -> [Element] {
        sorted { areInIncreasingOrder(predicate($0), predicate($1)) }
    }
}

public extension Sequence where Element: Comparable {

    func just(under value: Element) -> Element? {
        sorted().filter { $0 < value }.last
    }

    func just(above value: Element) -> Element? {
        sorted().filter { $0 > value }.first
    }

    /// XCTAssertEqual([9.30, 15.30].circularJust(under: 10), 9.30)
    /// XCTAssertEqual([9.30, 15.30].circularJust(under: 8), 15.30)
    /// XCTAssertEqual([9.30, 15.30].circularJust(under: 16), 15.30)
    func circularJust(under value: Element) -> Element? {
        just(under: value) ?? sorted().last
    }

    /// XCTAssertEqual([9.30, 15.30].circularJust(above: 10), 15.30)
    /// XCTAssertEqual([9.30, 15.30].circularJust(above: 8), 9.30)
    /// XCTAssertEqual([9.30, 15.30].circularJust(above: 16), 9.30)
    func circularJust(above value: Element) -> Element? {
        just(above: value) ?? sorted().first
    }
}


public extension Sequence where Element: Hashable {

    var set: Set<Element> { .init(self) }

    var allEqual: Bool { Set(self).count == 1 }

    /// Key = Element and value = count of that element
    var histogram: [Element: Int] { frequency }

    /// Key = Element and value = count of that element
    var frequency: [Element: Int] {
        reduce(into: [:]) { $0[$1, default: 0] += 1 }
    }

    /// The mode will be nil when the array is empty.
    var mode: Element? {
        if let (element, count) = frequency.maximum(\.value) {
            print("\(element) occurs \(count) times")
            return element
        } else {
            return nil
        }
    }
}
