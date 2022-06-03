//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension BinaryInteger {

    var string: String {
        String(self)
    }


    var isEven: Bool {
        self % 2 == 0
    }

    func floatingPoint<F: BinaryFloatingPoint>() -> F { .init(self) }
    var float:   Float   { floatingPoint() }

    var double:  Double  { floatingPoint() }
}


import CoreGraphics
public extension BinaryInteger {
    var cgFloat: CGFloat { floatingPoint() }
}
