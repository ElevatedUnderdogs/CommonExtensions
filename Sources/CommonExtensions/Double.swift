//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation
import CoreGraphics


typealias DoubleAction = (Double) -> Void

public extension Double {

    var whole: Self { rounded(.down) }

    var isWholeNumber: Bool { whole == self }

    var stringRemove0Decimal: String {
        isWholeNumber ? String(format: "%.0f", self) : string
    }
}

public extension Double {

    /// Converts `550754` to `"550,754"`
    var commasAdded: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self))
    }
}

public extension Double {

   // var int: Int { Int(self) }
    var float: CGFloat { CGFloat(self) }
}
