//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

/// CGPoint uses CGFloat for x and y.  Coordinate uses Int.
public struct Coordinate {
    var x: Int
    var y: Int

    /// O(1)
    func next(in direction: Direction) -> Coordinate {
        return Coordinate(original: self, direction: direction)
    }

    /// O(1)
    init(original: Coordinate, direction: Direction) {
        self = Coordinate(
            x: original.x + direction.xIncrement,
            y: original.y + direction.yIncrement
        )
    }

    /// O(1)
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}
