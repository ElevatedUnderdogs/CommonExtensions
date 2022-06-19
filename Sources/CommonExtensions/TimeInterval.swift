//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation
import CoreGraphics

public extension TimeInterval {
    
    var hoursToMinutes: Double {
        return self / 60.0
    }

    var timeString: String {
        let minutes = Int(self) / 60 % 60,
        seconds = Int(self) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }

    /// Eastern time zone
    static var easternStandard: TimeZone {
        get {
            TimeZone(abbreviation: "ES") ?? TimeZone(abbreviation: "ET") ?? TimeZone(abbreviation: "EST") ?? TimeZone(abbreviation: "EDT")!
        }
    }

    static func progress(in range: ClosedRange<Date>, current: Date = Date()) -> TimeInterval {
        progress(startDate: range.lowerBound, currentDate: current, endDate: range.upperBound)
    }

    static func progress(startDate: Date, currentDate: Date = Date(), endDate: Date) -> TimeInterval {
        (currentDate.timeIntervalSince1970 - startDate.timeIntervalSince1970) /
                    (endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970)
    }

    var cgFloat: CGFloat {
        CGFloat(self)
    }


    /// A time interval that covers a day.
    static var day: TimeInterval { 60.0 * 24.0 * 60.0 }

    /// There are 18 hours in the market day from 4AM to 8PM
    static var marketDay: TimeInterval { 60.0 * 18.0 }

    var decimal: Decimal { Decimal(self) }


    func minus(_ other: Double?) -> Double? {
        other.map { self - $0 }
    }

    func plus(_ other: Double?) -> Double? {
        other.map { self + $0 }
    }

    /// EST I think.
    var tdDate: Date {
        Date(timeIntervalSince1970: self / 1000)
    }

    init(between first: Double, and second: Double) {
        self = first - ((first - second) / 2)
    }

    /// Can be useful as a component of the standard deviation.
    /// - Parameter otherNum: Takes the current - othernum
    /// - Returns: The squared difference between the other number and this number.
    func squaredDifference(otherNum: Double?) -> Self? {
        otherNum.map { pow(abs(self - $0), 2)}
    }

    func multiplied(by multiplier: Double) -> Double { self * multiplier }
    func times(_ num: Double) -> Double { self * num }

    mutating func correctPrecisionError() {
        if self != 0 && self < 0.000_000_000_000_01 && self > -0.000_000_000_000_01 {
            print("WARNING: potential precision issue!: \(self)")
            self = 0
        }
    }

    /// chops off the decimal but returns nil if self is signed
    var uint: UInt?  { self >= 0 ? UInt(self) : nil }

    var int: Int { Int(self) }

    func zeroOutWhenMagnitude(lessThan threshold: Double) -> Double {
        magnitude < threshold ? .zero : self
    }

    /// Creates a stop loss at the lower bounds and exit point at the upper bounds.
    /// - Parameters:
    ///   - percentUp: Percent movement to define the upper exit
    ///   - percentDown: Percent movement to define the lower exit
    ///   - multiplier: multiplier for both the percent up and down.
    /// - Returns: Returns a closed range with the lowerbound as the stop loss and the upper bounds as the exit.
    func stopLossAndTarget(
        percentUp: Double,
        percentDown: Double,
        multiplier: Double = 1
    ) -> ClosedRange<Double> {
        self - (self * percentDown * multiplier)...self + (self * percentUp * multiplier)
    }
}
