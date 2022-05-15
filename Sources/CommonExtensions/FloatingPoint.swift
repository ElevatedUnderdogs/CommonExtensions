//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension FloatingPoint where Self: LosslessStringConvertible {
    /// Gets the decimal value from a Decimal.
    var fractionFromString: Decimal! {
        Decimal("0." + string.split(separator: ".").last.string)
    }
    var decimal: Decimal? {
        Decimal(string: string)
    }
}
public extension FloatingPoint {
    var whole: Self { modf(self).0 }
    var fraction: Self { modf(self).1 }
}
