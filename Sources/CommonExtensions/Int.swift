//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation


extension Int {
    var boolValue: Bool { return self != 0 }

    @discardableResult
    mutating func increment() -> Int {
        self = self + 1
        return self
    }

//    var string: String {
//        return String(self)
//    }

    var yearsInSeconds: Double {
        return Double(self) * 365 * 24 * 60 * 60
    }
//
//    static var frequencyOfLocationUpdatesInMinutes: Int {
//        get {
//            return Int(Keychain.loadFrom(key: locationFrequency) ?? "5") ?? 5
//        }
//        set(new) {
//            Keychain.save(key: locationFrequency, value: String(new))
//        }
//    }

//    var indexPaths: [IndexPath] {
//        return indexPaths()
//    }

//    ///Returns a corresponding indexpath totalling equal to the integer.
//    func indexPaths(inSection: Int = 1) -> [IndexPath] {
//        var indxPaths: [IndexPath] = []
//        for row in 0..<self {
//            indxPaths.append(IndexPath(row: row, section: inSection))
//        }
//        return indxPaths
//    }

    init?(_ optionalString: String?) {
        guard let string = optionalString, let int = Int(string) else { return nil }
        self = int
    }
}

extension Int {
    var int64: Int64 { Int64(self) }
}

extension Int {
    func degreesToRads() -> Double {
        return (Double(self) * .pi / 180)
    }
}

extension Int64 {
    /**
     Returns true if the number is even, false otherwise
     */
    var isEven: Bool {
        self % 2 == 0
    }

    var int: Int {
        Int(self)
    }
}


extension Int {
    var isOverZero: Bool { self > 0 && self == self }
}

extension Int {

//    var string: String { String(self) }
    func min(_ number: Self) -> Self { self < number ? number : self }
    var plurality: String { self == 1 ? "" : "s" }
    var double: Double { Double(self) }
}




extension Int {
    /// Includes a Nan check
    var isOverOne: Bool {
        self > 1 && self == self
    }
}

fileprivate extension Int64 {

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

//extension Int {
//
//    var string: String { String(self) }
//    func min(_ number: Self) -> Self { self < number ? number : self }
//    var plurality: String { self == 1 ? "" : "s" }
//    var double: Double { Double(self) }
//}
//
//extension Int64: DoubleConvertible {
//    var double: Double { Double(self) }
//}

extension UInt8 {
    var double: Double { Double(self) }
}
