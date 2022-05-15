//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation
import CoreGraphics

public extension CGSize {
    var smallSide: CGFloat {
        min(width, height)
    }
}
