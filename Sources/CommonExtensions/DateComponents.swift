//
//  File 5.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation


public extension DateComponents {

    /// Gets the count of the days and 0 when nil.
    var dayCount: Int {
        day ?? 0
    }

    /// Hour/s and minute/s in a 24 hour scale.
    /// Zeros out when hour and minute are unavailable
    var militaryTime: String {
        hour.orZero.string + ":" + minute.orZero.string
    }

    /// Used to describe days past for a range. in a user readable format.
    var daysPastExplanation: String {
        .localized(
            dayCount < 0 ? abs(dayCount).string + " day" + abs(dayCount).plurality + " ago" :
                dayCount > 0 ? dayCount.string + " day" + dayCount.plurality + " | " + militaryTime :
                "Today"
        )
    }

    static func firstMondayJune(year: Int) -> DateComponents {
        var firstMondayJune = DateComponents()
        firstMondayJune.month = 6
        firstMondayJune.weekdayOrdinal = 1  // 1st in month
        firstMondayJune.weekday = 2 // Monday
        firstMondayJune.year = year
        return firstMondayJune
    }

    static func easter(year: Int, using calendar: Calendar = .newYork) -> DateComponents? {
        // Easter calculation from Anonymous Gregorian algorithm
        // AKA Meeus/Jones/Butcher algorithm
        let a = year % 19
        let b = Int(floor(Double(year) / 100))
        let c = year % 100
        let d = Int(floor(Double(b) / 4))
        let e = b % 4
        let f = Int(floor(Double(b+8) / 25))
        let g = Int(floor(Double(b-f+1) / 3))
        let h = (19*a + b - d - g + 15) % 30
        let i = Int(floor(Double(c) / 4))
        let k = c % 4
        let L = (32 + 2*e + 2*i - h - k) % 7
        let m = Int(floor(Double(a + 11*h + 22*L) / 451))
        var dateComponents = DateComponents()
        dateComponents.month = Int(floor(Double(h + L - 7*m + 114) / 31))
        dateComponents.day = ((h + L - 7*m + 114) % 31) + 1
        dateComponents.year = year
        return calendar.date(from: dateComponents).map {
            calendar.dateComponents([.year, .month, .day, .weekday, .weekdayOrdinal], from: $0)
        }
    }
}
