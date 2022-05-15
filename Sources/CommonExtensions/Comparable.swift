//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension Comparable {
    mutating func max(_ x: Self) {
        self = Swift.max(self, x)
    }
    mutating func min(_ x: Self) {
        self = Swift.min(self, x)
    }
}
