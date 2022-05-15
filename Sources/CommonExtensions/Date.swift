//
//  File 4.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

extension Date {

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

    public var dayofTheWeek: String {
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

//    var entryDate: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = kMessaging_MMMddyyyy_FormatTypeI_Txt
//        return dateFormatter.string(from: self)
//    }
//
//    var fullEntryDate: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = kDateFormat_yyyy_MM_dd_Txt
//        return dateFormatter.string(from: self)
//    }

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

//    var readableDate: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = kDateFormat_MMMMddyyyy
//        return dateFormatter.string(from: self)
//    }

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

//    var graphDate: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = kMonthDateYearFormat_TypeIII
//        return dateFormatter.string(from: self)
//    }

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

//    var time: String {
//        Formatter.time.string(from: self)
//    }
//
//    var dateOnly: String {
//        Formatter.dateOnly.string(from: self)
//    }


    var isToday: Bool { isToday() }

    func isToday(using calendar: Calendar = .current) -> Bool {
        calendar.isDateInToday(self)
    }

//    var timeOfDay: String {
//        DateFormatter.currentTimeOfDay.string(from: self)
//    }

    func settingHour(bySettingHour hour: Int, minute: Int = 0, second: Int = 0,using calendar: Calendar = .current) -> Date? {
        calendar.date(bySettingHour: hour, minute: minute, second: second, of: self)
    }
}

extension Date {
    mutating func add(_ component: Calendar.Component, value: Int, wrappingComponents: Bool = false, using calendar: Calendar = .newYork) {
        self = adding(component, value: value, wrappingComponents: wrappingComponents, using: calendar)
    }
    func adding(_ component: Calendar.Component, value: Int, wrappingComponents: Bool = false, using calendar: Calendar = .newYork) -> Date {
        calendar.date(byAdding: component, value: value, to: self)!
    }
}


// MARK: - String From Date
/// warning: do not modify any of the shared formatter's properties
extension Date {

//    var newYorkISO8601: String { Formatter.newYorkISO8601.string(from: self) }
//
//    var newYorkTime: String { Formatter.newYorkTime.string(from: self) }
//
//    var localTime: String { Formatter.localTime.string(from: self) }
//
//    var iso8601: String { Formatter.iso8601.string(from: self) }
//
//    var iso8601withFractionalSeconds: String { Formatter.iso8601withFractionalSeconds.string(from: self) }
//
//    var iso8601NewYorkWithTZ: String { Formatter.iso8601NewYorkWithTZ.string(from: self) }
//
//    var csvTimeNewYork: String { Formatter.csvTimeNewYork.string(from: self) }
//
//    func quarter(using calendar: Calendar = .newYork) -> String {
//        if calendar == .newYork {
//            return "Q" + Formatter.nyQuarter.string(from: self)
//        }
//        print("WARNING a static quarter formatter was not provided for calendar: ", calendar, ".  This is inefficient.")
//        let formatter = DateFormatter()
//        formatter.calendar = calendar
//        formatter.timeZone = calendar.timeZone
//        formatter.dateFormat = "Q"
//        return  "Q" + formatter.string(from: self)
//    }


//    func monthSymbol(using calendar: Calendar = .newYork) -> String {
//        if calendar == .newYork {
//            return Formatter.nyMonthSymbol.string(from: self)
//        }
//        let dateFormatter = DateFormatter()
//        dateFormatter.calendar = calendar
//        dateFormatter.locale = .posix
//        dateFormatter.timeZone = calendar.timeZone
//        dateFormatter.dateFormat = "LLLL"
//        return dateFormatter.string(from: self)
//    }

//
//    /// format: "yyyy-MM-dd" for example 2006-06-01
//    func readableDate(calendar: Calendar) -> String {
//        if calendar == .newYork {
//            return Formatter.readableNY.string(from: self)
//        } else if calendar == .current {
//            return Formatter.readableCurrent.string(from: self)
//        }
//        print("WARNING a static readable formatter was not provided for calendar: ", calendar, ".  This is inefficient.")
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        dateFormatter.calendar = calendar
//        dateFormatter.timeZone = calendar.timeZone
//        return dateFormatter.string(from: self)
//    }

//    /// Format: "MM_dd_yy_HH_mm"
//    func readableDateTime(calendar: Calendar) -> String {
//        if calendar == .newYork {
//            return Formatter.readableDateTimeNY.string(from: self)
//        } else if calendar == .current {
//            return Formatter.readableDateTimeCurrent.string(from: self)
//        }
//        print("WARNING a static readable formatter was not provided for calendar: ", calendar, ".  This is inefficient.")
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM_dd_yy_HH_mm"
//        dateFormatter.calendar = calendar
//        dateFormatter.timeZone = calendar.timeZone
//        return dateFormatter.string(from: self)
//    }
}
//
//extension Date {
//
//    var isToday: Bool { isToday() }
//
//    func isToday(using calendar: Calendar = .current) -> Bool {
//        calendar.isDateInToday(self)
//    }
//
//    var timeOfDay: String {
//        DateFormatter.currentTimeOfDay.string(from: self)
//    }
//
//    func settingHour(bySettingHour hour: Int, minute: Int = 0, second: Int = 0,using calendar: Calendar = .current) -> Date? {
//        calendar.date(bySettingHour: hour, minute: minute, second: second, of: self)
//    }
//}
