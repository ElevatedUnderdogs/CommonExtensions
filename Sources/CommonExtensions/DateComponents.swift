//
//  File 5.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation


extension DateComponents {

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

//    static func memorialDay(year: Int, using calendar: Calendar = .newYork) -> DateComponents? {
//        Date.memorialDay(year: year).map {
//            calendar.dateComponents([.year, .month, .day, .weekday, .weekdayOrdinal], from: $0)
//        }
//    }

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

//    func isSTockMarketHoliday(using calendar: Calendar = .newYork) -> Bool {
//        guard let year = year,
//              let month = month,
//              let day = day,
//              let weekday = weekday,   // weekday is Sunday==1 ... Saturday==7
//              let nthInstanceOfWeekdayInMonth = weekdayOrdinal,
//              let easterDateComponents = DateComponents.easter(year: year, using: calendar),
//              let memorialDay = DateComponents.memorialDay(year: year, using: calendar)?.day,
//              let easterMonth = easterDateComponents.month,
//              let easterDay = easterDateComponents.day
//        else {
//            return false
//        }
//
//        switch (month, day, weekday, nthInstanceOfWeekdayInMonth) {
//        case (1, 1, _, _): return true                      // Happy New Years
//        case (1, _, 2, 3): return true                      // Martin Luther King - 3rd Mon in Jan
//        case (2, _, 2, 3): return true                      // Presidents day
//        case (easterMonth, easterDay - 2, _, _): return true// Good Friday: Friday, April 10
//        case (5, memorialDay, _, _): return true            // Memorial Day
//        case (7, 4, _, _): return true                      // Independence Day - 4th July
//        case (9, _, 2, 1): return true                      // Labor Day - 1st Mon in Sept
//        case (11, _, 5, 4): return true                     // Happy Thanksgiving - 4th Thurs in Nov
//        case (12, 25, _, _): return true                    // Christmas/Happy Holiday
//        default: return false
//        }
//    }
}
