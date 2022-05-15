//
//  File 11.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation


extension CGFloat {

    var int: Int {
        Int(self)
    }
}

extension CGFloat {

    func minus(_ number: Self) -> Self {
        self - number
    }

    func divided(by denominator: Self) -> Self {
        self / denominator
    }

    var square: CGSize {
        CGSize(width: self, height: self)
    }
}

extension CGFloat: LosslessStringConvertible {
    private static let formatter = NumberFormatter()
    public init?(_ description: String) {
        guard let cgFloat = Self.formatter.number(from: description) as? CGFloat else { return nil }
        self = cgFloat
    }
}
