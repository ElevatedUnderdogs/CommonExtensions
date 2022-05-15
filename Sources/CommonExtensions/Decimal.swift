//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation


public extension Decimal {
    /// returns 0 if positive, current value * -1 if negative
    /// Careful, the compiler reads: "-93.4.negativeOnly" as "-1 * 93.4.negativeOnly" not as "(-93.4).negativeOnly"
    var negativeOnly: Decimal { self < 0 ? self * -1 : 0 }

    /// returns 0 if negative, self value if positive
    var positiveOnly: Decimal { self > 0 ? self : 0 }

}

public extension Decimal {
    var isOverZero: Bool {
        self > 0 && !isNaN
    }
}

public extension Decimal {
    var isPositive: Bool {
        self >= .zero && !isNaN
    }
}

public extension Decimal {
    func isWithin(_ range: ClosedRange<Decimal>) -> Bool {
        range ~= self && !isNaN
    }
}

public extension Decimal {
    var isNotZero: Bool {
        value != .zero && !value.isNaN
    }
}


//
//public extension Direction {
//
//    /// You can initialize the direction by passing the dependent value as a Decimal.
//    /// - Parameter dependent: Recommend: `model.prediction(input: frame.modelInput()!).dependent.Decimal`
//    init?(dependent: Decimal?) {
//        if let direction = dependent?.direction {
//            self = direction
//        } else {
//            return nil
//        }
//    }
//
//    var polar: Polar? {
//        switch self {
//        case .up: return .up
//        case .down: return .down
//        case .level: return nil
//        }
//    }
//
//    enum Polar {
//        case up
//        case down
//
//        var multiplier: Decimal {
//            switch self {
//            case .up: return -1
//            case .down: return 1
//            }
//        }
//    }
//}


public enum Magnitudey {
    case negative, zero, positive

    init<T: Comparable>(compare first: T, to second: T) {
        self = first > second ? .positive :
            first < second ? .negative :
            .zero
    }
}

public extension Decimal {

    var mag: Magnitudey {
        self > .zero ? .positive :
            self < .zero ? .negative:
            .zero
    }
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

public extension Decimal {

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

//    func roundedNotZero(scale: Int = 0) -> NotZero {
//        let buffer = self
//        return (buffer.rounded(.down, scale: scale) == 0 ?
//                    buffer.rounded(.up, scale: scale) :
//                    buffer.rounded(.down, scale: scale)).notZero
//    }

    var whole: Self { rounded( self < 0 ? .up : .down) }

    var fraction: Self { self - whole }

    var isWholeNumber: Bool { whole == self }

  //  var positive: Positive { .init(stringLiteral: string) }

    var isNegative: Bool { self < 0 }

    var int: Int { whole.number.intValue }

    ///  Inits a target price to place an order with, either buy or sell price target
    ///
    /// **For Example**
    /// Market price = 10
    /// I want to buy
    /// Slippage is about 1cent
    /// I want 10 iterations
    /// So 10 -( 0.1 * 10) or $9 bid,
    /// Then 10 - (0.1 * 9) or $9.10 bid
    ///
    /// - Parameters:
    ///   - worstPriceOrMarket: worst price willing to accept or Market price.
    ///   - direction: estimated direction of the equity.
    ///   - increment: increment percent.  If you are targeting 1% of the worst price or market price to increment then pass 0.01.
    ///   - multiplier: The multiplier of the increment.
//    init(
//        worstPriceOrMarket: Self,
//        direction: Direction.Polar,
//        percent: Self,
//        multiplier: Int
//    ) {
//        self = worstPriceOrMarket + direction.multiplier * (percent * worstPriceOrMarket * multiplier.decimal)
//    }

    var double: Double { Double(truncating: self as NSNumber) }

    var choppedDouble: Double { rounded(scale: 14).double }

    func minus(_ other: Self?) -> Self? { other.map { self - $0 } }

    func plus(_ other: Self?) -> Self? { other.map { self + $0 }}

//    func divided(by divisor: OverZero) -> Self { self / divisor.value }
//
//    func divided(byOptional divisor: OverZero?) -> Self? { divisor.map { self / $0 } }

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

  //  var notZero: NotZero { NotZero(self)! }

    mutating func correctPrecisionError() {
        if self != 0 && self < 0.000_000_000_000_01 && self > -0.000_000_000_000_01 {
            print("WARNING: potential precision issue!: \(self)")
            self = 0
        }
    }

//    static func trend(_ early: Decimal?, _ later: Decimal?) -> Decimal? {
//        later?.minus(early)?.divided(byOptional: early?.overZero)
//    }

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


    /// Should init with TransactTarget type.  Inits a target price to place an order with.
    ///
    /// **For Example**
    /// Market price = 10
    /// I want to buy
    /// Slippage is about 1cent
    /// I want 10 iterations
    /// So 10 -( 0.1 * 10) or $9 bid,
//    /// Then 10 - (0.1 * 9) or $9.10 bid
//    ///
//    /// - Parameters:
//    ///   - worstPriceOrMarket: worst price willing to accept or Market price.
//    ///   - direction: estimated direction of the equity.
//    ///   - increment: increment percent.  If you are targeting 1% of the worst price or market price to increment then pass 0.01.
//    ///   - iterations: The multiplier of the increment.
//    init(
//        worstPriceOrMarket: Decimal,
//        direction: Direction,
//        increment percent: Decimal,
//        iterations: Int
//    ) {
//        switch direction {
//        case .up:
//            self = worstPriceOrMarket - (percent * worstPriceOrMarket * iterations.decimal)
//        case .down:
//            self = worstPriceOrMarket + (percent * worstPriceOrMarket * iterations.decimal)
//        case .level:
//            fatalError("Should not transact")
//        }
//    }

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
//
//    var trend: Trend { Trend(self) }
//
//    var direction: Trend { Direction(self) }

    var squareRoot: Decimal? {
        number.doubleValue.squareRoot().string.decimal
    }
}

public extension Decimal/*: HasValue*/ {
    init?(_ value: Decimal?) {
        guard let value = value else { return nil }
        self = value
    }

    init(stringLiteral value: String) {
        self.init(string: value)!
    }

    var value: Decimal { self }
}
