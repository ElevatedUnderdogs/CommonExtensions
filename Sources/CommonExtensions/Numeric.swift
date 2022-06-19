//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension Numeric {

    mutating func setAsProportionateHeight(
        width: Self,
        rectHeight: Self,
        rectWidth: Self
    ) where Self: FloatingPoint {
        guard rectWidth > 0 else { return }
        self = (width * rectHeight) / rectWidth
    }
}
