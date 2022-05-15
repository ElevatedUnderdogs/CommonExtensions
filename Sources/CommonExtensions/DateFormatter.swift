//
//  File 7.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation


extension DateFormatter {

    static var basic: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }

    static func formatter(with stringFormat: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = stringFormat
        return formatter
    }

    static var utc: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.timeZone = TimeZone.utc
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter
    }

    /// Made private to protect this from shared mutable state issues. Its mutable but less shared.
    /// Date Formatters are taxing to instantiate so this is instantiated just once.
    fileprivate static var currentTimeOfDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter
    }()

    convenience init(localTemplate: String) {
        self.init()
        setLocalizedDateFormatFromTemplate(localTemplate)
    }
}
