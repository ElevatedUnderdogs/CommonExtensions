//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}
