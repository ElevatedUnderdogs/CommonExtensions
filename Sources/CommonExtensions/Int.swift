//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension Int {
    var boolValue: Bool { return self != 0 }

    @discardableResult
    mutating func increment() -> Int {
        self = self + 1
        return self
    }

    var decimal: Decimal {
        Decimal(self)
    }

    var leadingZero: String {
        String(format: "%02d", self)
    }

    var yearsInSeconds: Double {
        return Double(self) * 365 * 24 * 60 * 60
    }

    init?(_ optionalString: String?) {
        guard let string = optionalString, let int = Int(string) else { return nil }
        self = int
    }

    var int64: Int64 { Int64(self) }

    func degreesToRads() -> Double {
        (Double(self) * .pi / 180)
    }

    var isOverZero: Bool { self > 0 && self == self }

    func min(_ number: Self) -> Self { self < number ? number : self }
    var plurality: String { self == 1 ? "" : "s" }
    var double: Double { Double(self) }
    /// Includes a Nan check
    var isOverOne: Bool {
        self > 1 && self == self
    }

    var string: String {
        String(self)
    }
}

public extension Int64 {
    /**
     Returns true if the number is even, false otherwise
     */
    var isEven: Bool {
        self % 2 == 0
    }

    var int: Int {
        Int(self)
    }

    /// Converts `550754` to `"550,754"`
    var commasAdded: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self))
    }

    /// Converts an int to a string, useful for optional chaining.
    var string: String {
        String(self)
    }
}

public extension UInt8 {
    var double: Double { Double(self) }
}
