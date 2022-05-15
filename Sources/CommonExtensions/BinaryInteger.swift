//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

extension BinaryInteger {

    var string: String {
        String(self)
    }


    var isEven: Bool {
        self % 2 == 0
    }

    func floatingPoint<F: BinaryFloatingPoint>() -> F { .init(self) }
    var float:   Float   { floatingPoint() }
    var cgFloat: CGFloat { floatingPoint() }
    var double:  Double  { floatingPoint() }
    var float80: Float80 { floatingPoint() }
}
