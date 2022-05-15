//
//  File 9.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation


public extension Calendar {
    func dayOfWeek(_ date: Date) -> Int {
        var dayOfWeek = self.component(.weekday, from: date) + 1 - self.firstWeekday

        if dayOfWeek <= 0 {
            dayOfWeek += 7
        }

        return dayOfWeek
    }

    func startOfWeek(_ date: Date) -> Date {
        return self.date(byAdding: DateComponents(day: -self.dayOfWeek(date) + 1), to: date)!
    }

    func endOfWeek(_ date: Date) -> Date {
        return self.date(byAdding: DateComponents(day: 6), to: self.startOfWeek(date))!
    }

    func startOfMonth(_ date: Date) -> Date {
        return self.date(from: self.dateComponents([.year, .month], from: date))!
    }

    func endOfMonth(_ date: Date) -> Date {
        return self.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth(date))!
    }

    func startOfQuarter(_ date: Date) -> Date {
        let quarter = (self.component(.month, from: date) - 1) / 3 + 1
        return self.date(from: DateComponents(year: self.component(.year, from: date), month: (quarter - 1) * 3 + 1))!
    }

    func endOfQuarter(_ date: Date) -> Date {
        return self.date(byAdding: DateComponents(month: 3, day: -1), to: self.startOfQuarter(date))!
    }

    func startOfYear(_ date: Date) -> Date {
        return self.date(from: self.dateComponents([.year], from: date))!
    }

    func endOfYear(_ date: Date) -> Date {
        return self.date(from: DateComponents(year: self.component(.year, from: date), month: 12, day: 31))!
    }

    func getPreviousOrNext(component: Calendar.Component, value: Int, fromDate: Date) -> Date? {
        return self.date(byAdding: component, value: value, to: fromDate)
    }

    func getDateForDivider(value: Int, fromDate: Date) -> Date? {
        return self.date(byAdding: .day, value: value, to: fromDate)
    }

    func getMonthForYear(value: Int, fromDate: Date) -> Date? {
        return self.date(byAdding: .month, value: value, to: fromDate)
    }

    func getNumberOfDaysInMonth(for date: Date) -> Int {
        if let range = self.range(of: .day, in: .month, for: date) {
            return range.count
        }
        return 0
    }
    func getNumberOfWeeksInQuarter(for date: Date) -> Int {
        if let range = self.range(of: .weekdayOrdinal, in: .quarter, for: date) {
            return range.count-1
        }
        return 0
    }
    func diffInDays(dateFrom: Date, dateTo: Date) -> Int? {
        let components = Set<Calendar.Component>([.day])
        let differenceOfDate = Calendar.current.dateComponents(components, from: dateFrom, to: dateTo)

        return differenceOfDate.day
    }
}

public extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
    static let iso8601 = Calendar(identifier: .iso8601)
    static let newYork: Calendar = {
        var calendar: Calendar = .gregorian
        calendar.locale = .posix
        calendar.timeZone = .newYork
        return calendar
    }()
    static let losAngeles: Calendar = {
        var calendar: Calendar = .gregorian
        calendar.locale = .posix
        calendar.timeZone = .losAngeles
        return calendar
    }()
}
