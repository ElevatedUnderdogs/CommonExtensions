//
//  File 4.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension Date {

    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
       return self.toTime(isGlobalOrLocal: true)
    }

    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        return self.toTime(isGlobalOrLocal: false)
    }

    func toTime(isGlobalOrLocal: Bool) -> Date {
        let timezone = TimeZone.current
        let seconds = isGlobalOrLocal ? -TimeInterval(timezone.secondsFromGMT(for: self)) : TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

    func removeTimeStamp() -> Date {
        let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self))
        return date ?? self
    }
    func weekOfYear() -> Int {
        let weekOfYear = Calendar.current.component(.weekOfYear, from: self)
        return weekOfYear
    }

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tommorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }

    /// time returns a Decimal for which the integer represents the hours from 1 to 24 and the decimal value represents the minutes.
    func time(using calendar: Calendar = .current) -> Decimal {
        calendar.component(.hour, from: self).decimal + calendar.component(.minute, from: self).decimal / 100
    }

    var greeting: String {
        let thisTime =  time()
        if thisTime >= 2 && thisTime < 12 {
            return "Good Morning"
        } else if thisTime >= 12 && thisTime < 18 {
            return "Good Afternoon"
        } else {
            return "Good Evening"
        }
    }


    var dayofTheWeek: String {
        let dayNumber = Calendar.current.component(.weekday, from: self)
        // day number starts from 1 but array count from 0
        return daysOfTheWeek[dayNumber - 1]
    }

    var dayOfMonth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }

    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }

    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }

    var graphXAxisDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d"
        return dateFormatter.string(from: self)
    }

    var quarterDisplayStartDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: self)
    }

    var stringOnMMddyy: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: self)
    }

    var quarterDisplayEndDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }

    func totalNumberOfDays(endDate: Date) -> Int {
        Calendar.current.dateComponents([.day], from: self, to: endDate).day ?? 0
    }

    func totalNumberOfWeeks(endDate: Date) -> Int {
        let totalWeeks = Calendar.current.dateComponents([.weekOfMonth], from: self, to: endDate).weekOfMonth
        return totalWeeks ?? 0
    }

    func totalNumberOfMonths(endDate: Date) -> Int {
        let totalWeeks = Calendar.current.dateComponents([.month], from: self, to: endDate).month
        return totalWeeks ?? 0
    }

    var monthOfDateInInt: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: self)
    }

    internal var daysOfTheWeek: [String] {
        return  ["Su", "M", "Tu", "W", "Th", "F", "Sa"]
    }

    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate

        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }

    func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
        return date1.dayBefore.compare(self) == self.compare(date2.tommorrow)
    }

    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }

    func adding(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }

    func adding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }

    var string: String {
        "\(self)"
    }

    func formatted(with dateFormatter: DateFormatter) -> String {
        dateFormatter.string(from: self)
    }

    typealias Minutes = Int

    init?(timeFromNow: Minutes) {
        guard let date = Calendar.current.date(byAdding: .minute, value: timeFromNow, to: Date()) else { return nil}
        self = date
    }

    var clockTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.locale = .current
        return dateFormatter.string(from: self)
    }

    var minutesSinceNow: Int {
        return Int(timeIntervalSinceNow / 60.0)
    }

    var secondsSinceNow: Double {
        return timeIntervalSinceNow
    }

    var isOlderThan18: Bool {
        return self.secondsSinceNow > 18.yearsInSeconds
    }

    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }

    var apiString: String {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd HH:mm:ss"
        df.timeZone = TimeZone(identifier: "GMT")
        return df.string(from: self)
    }

    var isToday: Bool { isToday() }

    func isToday(using calendar: Calendar = .current) -> Bool {
        calendar.isDateInToday(self)
    }

    func settingHour(bySettingHour hour: Int, minute: Int = 0, second: Int = 0,using calendar: Calendar = .current) -> Date? {
        calendar.date(bySettingHour: hour, minute: minute, second: second, of: self)
    }

    mutating func add(_ component: Calendar.Component, value: Int, wrappingComponents: Bool = false, using calendar: Calendar = .newYork) {
        self = adding(component, value: value, wrappingComponents: wrappingComponents, using: calendar)
    }
    func adding(_ component: Calendar.Component, value: Int, wrappingComponents: Bool = false, using calendar: Calendar = .newYork) -> Date {
        calendar.date(byAdding: component, value: value, to: self)!
    }
}
