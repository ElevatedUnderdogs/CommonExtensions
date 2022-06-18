//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension String {

    // For apns primarily
    static var environmentString: String {
        #if DEBUG
            return "DEBUG"
        #elseif ADHOC
            return "ADHOC"
        #else
            return "PRODUCTION"
        #endif
    }

    // MARK - computed properties

    ///Returns an empty string when there is no path.
    func substring(from left: String, to right: String) -> String {
        if let match = range(of: "(?<=\(left))[^\(right)]+", options: .regularExpression) {
            return String(self[match])
        }
        return ""
    }

    var deterministicHash: UInt64 {
        var result = UInt64 (5381)
        let buf = [UInt8](utf8)
        for b in buf {
            result = 127 * (result & 0x00ffffffffffffff) + UInt64(b)
        }
        return result
    }
//
//    var path: String {
//        return substring(from: UserDefaults.baseUrlToUse, to: ".php?")
//    }

    var asURL: URL? {
        return URL(string: self)
    }

    var hasACharacter: Bool {
        return count > 0
    }

    var isNotValidEmail: Bool {
        return !isValidEmail
    }

    var isValidEmail: Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    static var generateBoundaryString: String {
        return "Boundary-\(NSUUID().uuidString)"
    }

    // MARK - self variations

    var nonSpaceCharacters: String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }

    var lowercased: String {
        return lowercased()
    }

    var int: Int? {
        return Int(self)
    }

    var privacyDots: String {
        return String (self.map {_ in return Character("*")})
    }

    func times(_ int: Int) -> [String] {
        return Array(0...int - 1).map { _ in self}
    }

    var intBool: Bool {
        return self == "1"
    }

    var date: Date? {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd HH:mm:ss"
        df.timeZone = TimeZone(identifier: "GMT")
        return df.date(from: self)
    }

    var dateFromAPI: Date? {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd HH:mm:ss"
        df.timeZone = TimeZone(identifier: "GMT")
        return df.date(from: self)
    }

    var scaped: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }

//    func typography(spacing: CGFloat) -> AttributedString {
//        let str = AttributedString(string: self)
//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = spacing
//        str.addAttribute(
//            .paragraphStyle,
//            value: style,
//            range: NSMakeRange(0, self.count)
//        )
//        return str
//    }

//    func bold(string boldString: String, font: UIFont) -> NSAttributedString {
//        let attributedString = NSMutableAttributedString(
//            string: self,
//            attributes: [NSAttributedString.Key.font: font]
//        )
//        let boldFontAttribute: [NSAttributedString.Key: Any] = [
//            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)
//        ]
//        let range = (self as NSString).range(of: boldString)
//        attributedString.addAttributes(
//            boldFontAttribute,
//            range: range
//        )
//        return attributedString
//    }

    // MARK - initializers

    init(key: String, _ value: String) {
        self = "\(key)=\(value.scaped ?? "")&"
    }

    static var appVersion: String? {
        return Bundle.version
    }

    static var uniqueid: String {
        return NSUUID().uuidString.replacingOccurrences(of: "-", with: "")
    }

    func hasSpecialCharacters() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                return true
            }

        } catch {
            debugPrint("ERROR: ", error.localizedDescription, "for has special characters.")
            return false
        }

        return false
    }

//    func privacyDots() -> String {
//        return String (self.map {_ in return Character("*")})
//    }

    /// Not localized! This is a component that should be added prior to localization.
    /// - Parameters:
    ///   - current: current date or the date for comparison to the end date.
    ///   - end: end date.
    /// - Returns: returns the past tense modifier.
    static func pastTenseCurrentTenseModifier(current: Date = Date(), end: Date?) -> String {
        guard let end = end else { return "" }
        return current > end ? "ed" : "s"
    }

    static func beginAndEndDateEnrollement(current: Date = Date(), end: Date?, begin: Date?) -> String {
        guard let end = end, let begin = begin else { return "" }
        return current < begin ? "begins" : current > end ? "ended" : "ends"
    }

    static func localized(_ string: String) -> String {
        NSLocalizedString(string, comment: string)
    }

    var localized: String {
        String.localized(self)
    }

    var int64: Int64? {
        NumberFormatter().number(from: self) as? Int64
    }

    func date(dateFormatter: DateFormatter) -> Date? {
        dateFormatter.date(from: self)
    }

    var convertToDateOnMMddyyyy: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: self)
    }

    /// Default format is: "yyyy-MM-dd'T'HH:mm:ssZ"
    /// - Parameter format: dateformat of the string
    /// - Returns: returns the date.
    func date(format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }

    static var yyyymmddHHmmssZ: String {
        "yyyy-MM-dd HH:mm:ss Z"
    }
//
//    func convertToAttributedStringWith(lineSpace lineSpacing: CGFloat, font: UIFont) -> NSAttributedString {
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = lineSpacing
//
//        let attributes: [NSAttributedString.Key: Any] = [
//            .font: font,
//            .paragraphStyle: paragraphStyle
//        ]
//
//        let attributedStr = NSAttributedString.init(string: self, attributes: attributes)
//        return attributedStr
//    }

    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }

    init(swiftLintMultiline strings: String...) {
        self = strings.reduce("", +)
    }

    var url: URL? {
        URL(string: self)
    }

    var nsString: NSString {
        self as NSString
    }
}

public extension String {

    static var companyName: String { #function }
    static var inviteCode: String { #function }

    var isValidName: Bool { !hasSpecialCharacters() && count > 1 }
    var isValidPassword: Bool { count > 6 }
    var isValidCompanyName: Bool { isValidName }
    var isValidCode: Bool { count > 10 }


//    var isValidEmail: Bool {
//        NSPredicate(
//            format:"SELF MATCHES %@",
//            "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        )
//        .evaluate(with: self)
//    }

//    var hasSpecialCharacters: Bool {
//        (try? NSRegularExpression(
//            pattern: ".*[^A-Za-z0-9].*",
//            options: .caseInsensitive
//        ).firstMatch(
//            in: self,
//            options: NSRegularExpression.MatchingOptions.reportCompletion,
//            range: NSMakeRange(0, self.count)
//        )) != nil
//    }
}

public extension String {

    var fileurl: URL? {
        URL(fileURLWithPath: self)
    }

//    var int: Int? {
//        Int(self)
//    }
}

public extension String {

    /// creates a local model url from a string.
    var localModelURL: URL {
        URL(fileURLWithPath: self + (self.contains(".mlmodel") ? "" : ".mlmodel"))
    }
}




public extension String {


    static let line = "\n-----------------\n\n"




    struct WriteToFileParams {
        let desktopPath: String
        let name: String
        let fileEnding: String
    }

//    @discardableResult internal func writeToFile(
//        _ writeToFileParams: WriteToFileParams
//    ) throws -> URL {
//        try writeToFile(
//            desktopPath: writeToFileParams.desktopPath,
//            name: writeToFileParams.name,
//            fileEnding: writeToFileParams.fileEnding
//        )
//    }


//    /// creates a file locally.
//    /// - Parameters:
//    ///   - desktopPath: Starts without a slash, ends with a slash.  Assumes the path starts after the desktop path is established. alt: `"iOS/TimeFountain/TimeFountain/"`
//    ///   - name: Pass a name ie. ticker + .currentDate
//    ///   - fileEnding: File ending such as csv.  The period is not required.
//    /// - Returns: If its a success, it returns the resulting url string, else returns a discardeable Resullt to account for multiple possible errors.
//    @discardableResult internal func writeToFile(
//        desktopPath: String = "iOS/DataFrame/",
//        name: String,
//        fileEnding: String
//    ) throws -> URL  {
//        if !contains(where: \.isNewline) {
//            throw GenericError(text:
//                """
//                WARNING: the text does not contain any new lines...Is that intentional?
//                1. perhpas you chose not to print or used a linked list for columns instead of an array.
//                2. All the rows were removed because they all contained nil. In other words, your columns did not reach the minimum range.
//                3. Perhaps the split date was too aggressive in the past.
//                """
//            )
//        } else if count < 10 {
//            throw GenericError(text: "WARNING: the text has fewer than 10 characters.  Thats short. ")
//        }
//        let fileURL = try URL.local(
//            desktopPath: desktopPath,
//            name: name,
//            fileEnding: fileEnding,
//            fileManager: FileManager.default
//        )
//        try fileURL.write(content: self)
//        return fileURL
//    }
//
//
//    func bundleURL(with type: String = "csv", bundle: Bundle = .main) throws -> URL {
//        guard let url = bundle.url(forResource: self, withpublic extension: type) else {
//            throw Bundle.Error.notFound
//        }
//        return url
//    }
    /// Let the string be only the name of the file, excluding the path, and excluding the csv file ending.
//    func csvString() throws -> Self {
//        try String(contentsOf: bundleURL(), encoding: .utf8)
//    }

    var numberLinted: String {
        replacing(["_", ",", " "])
    }

    var double: Double? { Double(numberLinted) }
    var decimal: Decimal? { Decimal(string: numberLinted) }


//    internal func json() throws -> [String: Any] {
//        guard let data8 = data(using: .utf8) else {
//            throw GenericError(text: "Could not convert the string to data.")
//        }
//        if let json = try JSONSerialization.jsonObject(with: data8, options: .allowFragments) as? [String: Any] {
//            return  json
//        } else {
//            throw GenericError(text: "Error: Invalid JSON")
//        }
//    }

    func equalsUnderscoreSpaces(_ other: String) -> Bool {
        replacing(["_", ":"], with: " ") == other.replacing(["_", ":"], with: " ")
    }

//    /// Assumes self is the full file url string or complete address.
//    func read() throws -> String {
//        guard let url = URL(string: self) else {
//            throw GenericError(text: "Could not convert this into a url")
//        }
//        return try String(contentsOf: url)
//    }

    func remove(_ substrings: String...) -> String {
        var str = self
        for string in substrings {
            str = str.replacingOccurrences(of: string, with: "")
        }
        return str
    }


    func matches(for regex: String) throws -> [String] {
        try NSRegularExpression(pattern: regex).matches(
            in: self,
            range: NSRange(startIndex..., in: self)
        ).map {
            String(self[Range($0.range(at: 1), in: self)!])
        }
    }

//    static func refreshMessage(_ refreshToken: String?, or fromCredentials: String) -> String {
//        refreshToken != nil ? "" :
//            fromCredentials != "" ? .passedNilRefreshToken :
//            .failedToGetRefreshToken
//    }

    static var tdAmeritradeFormat: String {
        "yyyy-MM-dd'T'HH:mm:ssZ"
    }

    var withoutWhitespace: String {
        replacing(["\n", "\r", "\0"])
    }

    func replacing<T>(_ strings: [T], with replacement: String = "") -> String where T: StringProtocol {
        var buffer: String = self
        for string in strings {
            buffer = buffer.replacingOccurrences(of: string, with: replacement)
        }
        return buffer
    }

    func localized(withComment:String = "", fileName: String?) -> String {
        NSLocalizedString(
            self,
            tableName: fileName,
            bundle: Bundle.main,
            value: "",
            comment: withComment
        )
    }



    /// creates or writes to a file at the given path.
    /// - Parameter path: The path on the desktop.
//    func write(to path: String) throws {
//        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
//            try write(
//                to: dir.appendingPathComponent(path),
//                atomically: false,
//                encoding: .utf8
//            )
//        } else {
//            throw GenericError(text: "Could not get a directory for the path: \(path)")
//        }
//    }



    static func slashes(_ folders: String...) -> String {
        folders.joined(separator: "/")
    }

    static func slashes(_ folders: [String]) -> String {
        folders.joined(separator: "/")
    }
//
//    var int: Int? {
//        Int(numberLinted)
//    }

    /// infinity translated to decimal
    static var infinity: String {
        "105_110_102_105_110_105_116_121".numberLinted
    }

    /// neg infinity translated to decimal
    static var negativeInfinity: String {
        "-110 101 103 32 105 110 102 105 110 105 116 121".numberLinted
    }

    static func finhubStream(ticker: String) throws -> String? {
        try [
            "type":"subscribe",
            "symbol":ticker
        ].stringified()
    }

    var data: Data? {
        data(using: .utf8)
    }

//    static func failedCandlesWarning(for timer: Timer, since date: Date) -> String {
//        "WARNING!!: We did not get any new candles for fireDate\(timer.fireDate.newYorkTime), \(timer.fireDate.timeIntervalSince(date))"
//    }

//    static func mlModelName(
//        ticker: String,
//        period: URL.Period,
//        targetMethod: TargetMethod,
//        backTestTo: Date,
//        calendar: Calendar
//    ) -> String {
//            ticker + "_" +
//            period.string + "_" +
//            targetMethod.rawValue + "_" +
//            backTestTo.readableDateTime(calendar: calendar)
//    }

    func appendLineToURL(fileURL: URL) throws {
        try (self + "\n").appendToURL(fileURL: fileURL)
    }

    func appendToURL(fileURL: URL) throws {
        try data(using: String.Encoding.utf8)!.append(fileURL: fileURL)
    }

}

public extension String {
    func floatingPoint<T: FloatingPoint>() -> T? where T: LosslessStringConvertible { T(self) }
}

public extension String {

    static func bundlePath(for resource: String = "Content", of type: String = "json") -> Self {
        Bundle.main.path(forResource: resource, ofType: type)!
    }
//
//    var url: URL? {
//        URL(string: self)
//    }
//
//    var fileurl: URL? {
//        URL(fileURLWithPath: self)
//    }
//
//    var int: Int? {
//        Int(self)
//    }
}

// MARK: - Date From String
/// warning: do not modify any of the shared formatter's properties
//public extension String {
//
//    var newYorkISO8601: Date? { Formatter.newYorkISO8601.date(from: self) }
//
//    var dateFromReadableDateTime: Date? { Formatter.newYorkMMddyyHHmm.date(from: self) }
//
//    var tdDate: Date? {
//        Formatter.tdDateFormatter.date(from: self)
//    }
//}

public extension String {

    static var lorem: String {
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation..."
    }

    static var alphaNumeric: String {
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    }

    static func random(length: Int) -> String {
        String((0..<length).compactMap { _ in String.alphaNumeric.randomElement() })
    }

    /// 􀁜
    static var questionMarkSymbol: String { "questionmark.circle" }

    /// 􀐫
    static var clock: String { #function }

    /// 􀙇
    static var wifi: String { #function }

    /// 􀆨
    static var power: String { #function }

    /// 􀆊
    static var rightArrow: String { "chevron.right" }

    /// 􀆉
    static var leftArrow: String { "chevron.left" }

    /// 􀄫
    static var rightArrowLine: String { "arrow.right" }

    /// 􀆄
    static var close: String { "xmark" }
}

extension String {

    /// O(1)
    subscript(safe range: ClosedRange<Int>) -> String {
        get {
            let start = String.Index(utf16Offset: range.lowerBound, in: self)
            let end = String.Index(utf16Offset: range.upperBound, in: self)
            return String(self[start...end])
        }
    }

    /// O(1)
    subscript(index: Int) -> String {
        get {
            let index = String.Index(utf16Offset: index, in: self)
            return String(self[index])
        }
    }


    /// Expects the string to be in the format "name.type", for example "local.json"
    public var localData: Data? {
        let comps = components(separatedBy: ".")
        guard let first = comps.first,
              let second = comps[safe: 1],
              let path = Bundle.main.path(forResource: first, ofType: second),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            return nil
        }
        return data
    }

    /// Separates the text into paragraphs.
    public var paragraphs: [String] {
        components(separatedBy: "\n")
    }
}
