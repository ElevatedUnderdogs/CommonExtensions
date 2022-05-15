//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation


public extension MutableCollection where Self: RandomAccessCollection {
    mutating func sort<T: Comparable>(_ predicate: (Element) -> T, by areInIncreasingOrder: ((T, T) -> Bool) = (<)) {
        sort { areInIncreasingOrder(predicate($0), predicate($1)) }
    }
}
