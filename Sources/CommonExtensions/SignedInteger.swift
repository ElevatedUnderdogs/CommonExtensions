//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation
import CoreGraphics

public extension SignedInteger {

    var plurality: String {
        self > 1 ? "s" : ""
    }

    var cgFloat: CGFloat {
        CGFloat(self)
    }
}
