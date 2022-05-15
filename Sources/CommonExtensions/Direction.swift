//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public enum Direction: CaseIterable {
    case up
    case down
    case left
    case right
    case upright
    case upleft
    case downright
    case downleft

    /// O(1)
    var yIncrement: Int {
        switch self {
        case .up, .upleft, .upright:
            return -1
        case .left, .right:
            return 0
        case .down, .downright, .downleft:
            return 1
        }
    }

    /// O(1)
    var xIncrement: Int {
        switch self {
        case .up, .down:
            return 0
        case .left, .upleft, .downleft:
            return -1
        case .right, .upright, .downright:
            return  1
        }
    }
}
