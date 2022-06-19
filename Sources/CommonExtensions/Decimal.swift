//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public enum Magnitudey {
    case negative, zero, positive

    init<T: Comparable>(compare first: T, to second: T) {
        self = first > second ? .positive :
            first < second ? .negative :
            .zero
    }
}

public extension Decimal {
    /// returns 0 if positive, current value * -1 if negative
    /// Careful, the compiler reads: "-93.4.negativeOnly" as "-1 * 93.4.negativeOnly" not as "(-93.4).negativeOnly"
    var negativeOnly: Decimal { self < 0 ? self * -1 : 0 }

    /// returns 0 if negative, self value if positive
    var positiveOnly: Decimal { self > 0 ? self : 0 }

    var isOverZero: Bool {
        self > 0 && !isNaN
    }

    var isPositive: Bool {
        self >= .zero && !isNaN
    }

    func isWithin(_ range: ClosedRange<Decimal>) -> Bool {
        range ~= self && !isNaN
    }

    var isNotZero: Bool {
        value != .zero && !value.isNaN
    }

    var mag: Magnitudey {
        self > .zero ? .positive :
            self < .zero ? .negative:
            .zero
    }

    /// Rounds a value
    /// - Parameters:
    ///   - roundingMode: up down plain or bankers
    ///   - scale: the number of digits result can have after its decimal point
    /// - Returns: the rounded number
    func rounded(_ roundingMode: NSDecimalNumber.RoundingMode = .bankers, scale: Int = 0) -> Self {
        var result = Self()
        var number = self
        NSDecimalRound(&result, &number, scale, roundingMode)
        return result
    }

    var roundedStandard: Decimal {
        rounded(.up, scale: 7)
    }

    var whole: Self { rounded( self < 0 ? .up : .down) }

    var fraction: Self { self - whole }

    var isWholeNumber: Bool { whole == self }

    var isNegative: Bool { self < 0 }

    var int: Int { whole.number.intValue }

    var double: Double { Double(truncating: self as NSNumber) }

    var choppedDouble: Double { rounded(scale: 14).double }

    func minus(_ other: Self?) -> Self? { other.map { self - $0 } }

    func plus(_ other: Self?) -> Self? { other.map { self + $0 }}

    var abs: Self { Swift.abs(self) }

    /// Can be useful as a component of the standard deviation.
    /// - Parameter otherNum: Takes the current - othernum
    /// - Returns: The squared difference between the other number and this number.
    func differenceSquared(otherNum: Decimal?) -> Self? {
        otherNum.map { pow(Swift.abs(self - $0), 2)}
    }

    func multiplied(by multiplier: Decimal) -> Decimal { self * multiplier }

    func times(_ num: Decimal) -> Decimal { self * num }

    func zeroOutWhenMagnitude(lessThan threshold: Decimal) -> Decimal {
        magnitude < threshold ? .zero : self
    }

    mutating func correctPrecisionError() {
        if self != 0 && self < 0.000_000_000_000_01 && self > -0.000_000_000_000_01 {
            print("WARNING: potential precision issue!: \(self)")
            self = 0
        }
    }

    /// chops off the decimal but returns nil if self is signed
    var uint: UInt? { self >= 0 ? UInt(whole.string) : nil }

    /// Creates a stop loss at the lower bounds and exit point at the upper bounds.
    /// - Parameters:
    ///   - percentUp: Percent movement to define the upper exit
    ///   - percentDown: Percent movement to define the lower exit
    ///   - multiplier: multiplier for both the percent up and down.
    /// - Returns: Returns a closed range with the lowerbound as the stop loss and the upper bounds as the exit.
    func stopLossAndTarget(
        percentUp: Decimal,
        percentDown: Decimal,
        multiplier: Decimal = 1
    ) -> ClosedRange<Decimal> {
        self - (self * percentDown * multiplier)...self + (self * percentUp * multiplier)
    }

    var number: NSDecimalNumber { self as NSDecimalNumber }

    init(between first: Decimal, and second: Decimal) {
        self = first - ((first - second) / 2)
    }

    /// heuristically reserved large number spelling infinity in decimal representation
    static var infinity: Decimal { Decimal(string: .infinity)! }

    /// heuristically reserved small number spelling neg infinity in decimal representation
    static var negativeInfinity: Decimal { Decimal(string: .negativeInfinity)! }


    /// Scott's rsi placement indicator.  Heuristically establishes positive and negative infinity for clustering
    /// - Parameters:
    ///   - gains: the gains average
    ///   - losses: the losses average
    /// - Returns: returns a hueristically large number for infinity, heuristically small number for negative infinity
    func placement(
        between gains: Decimal,
        and losses: Decimal
    ) -> Decimal {
        gains != losses ? (self - losses) / (gains - losses) :
            self > gains ? .infinity :
            self < gains ? .negativeInfinity :
            0.5
    }

    /// Rounding function
    /// - Parameter digit: 1 rounds to one digit, 2 rounds to the second digit after the decimal.
    /// - Returns: The rounded value.
    func roundedTo(digit: Int) -> Decimal {
        let exp = pow(Decimal(10), digit)
        return (exp * self).whole / exp
    }

    var squareRoot: Decimal? {
        number.doubleValue.squareRoot().string.decimal
    }

    // MARK: - HasValue

    init?(_ value: Decimal?) {
        guard let value = value else { return nil }
        self = value
    }

    init(stringLiteral value: String) {
        self.init(string: value)!
    }

    var value: Decimal { self }
}


public extension AdditiveArithmetic where Self: Comparable {

    var mag: Magnitudey {
        self > .zero ? .positive :
            self < .zero ? .negative :
            .zero
    }
}

public extension Sequence where Element: AdditiveArithmetic {
    var sum: Element {
        reduce(.zero, +)
    }
}

extension Decimal: LosslessStringConvertible {

    public init?(_ description: String) {
        self.init(string: description.numberLinted)
    }
}
