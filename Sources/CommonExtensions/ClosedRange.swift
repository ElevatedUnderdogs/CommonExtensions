//
//  File 10.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation


public extension ClosedRange where Bound == Date {

    /// Usage:
    ///  1. Takes the range of time from a start date to an end date
    ///  and breaks that range into days, hours, and minutes.
    ///
    /// - Parameter calendar: calendar used to create date components
    /// - Returns: the date components from the lowerbound date to upperbound date.
    func components(calendar: Calendar = .current) -> DateComponents {
        calendar.dateComponents([.day, .hour, .minute], from: lowerBound, to: upperBound)
    }

    static var example: Self {
        Date()...Calendar.current.date(byAdding: .day, value: 2, to: Date())!
    }

    func readable(locale: Locale = .current) -> String {
        let dif = DateIntervalFormatter()
        dif.dateStyle = .medium
        dif.timeStyle = .none
        dif.locale = .current
        return dif.string(from: lowerBound, to: upperBound)
    }

    var timeInterval: TimeInterval {
        upperBound.timeIntervalSince(lowerBound)
    }
}

public extension ClosedRange {

    /// Initializes a range safely.
    /// - Parameters:
    ///   - lower: lower bound
    ///   - upper: upper bound
    /// - Returns: returns nil if the lower bound is greater than the upper bound.
    /// Otherwise returns a range from the arguments
    static func safeRange(_ lower: Bound, to upper: Bound) -> Self? {
        guard lower < upper else { return nil }
        return lower...upper
    }

    func overlapsSpace(_ other:Self) -> Bool {
        (other.lowerBound < lowerBound && lowerBound < other.upperBound) ||
            (other.lowerBound < upperBound && upperBound < other.upperBound) ||
            (lowerBound < other.lowerBound && other.lowerBound < upperBound) ||
            (lowerBound < other.upperBound && other.upperBound < upperBound)
    }
}
