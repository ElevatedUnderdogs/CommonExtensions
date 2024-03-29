//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension String {

    static var randomIPAddress: String {
        (1...4).map { _ in Int.random(in: (0...255))}.map(\.string).joined(separator: ".")
    }

    static var ipAddressPattern: String {
        "(?<=inet\\s)\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}"
    }

    /// The file save path
    /// - Parameter path: path where you want to save the csv.
    func saveTo(path: URL) {
        do {
            try write(
                to: path,
                atomically: true,
                encoding: .utf8
            )
        } catch let error {
            print("error creating file, are you in an iOS app trying to save to desktop which requires MacOS? Did you disable the sandbox setting? If you haven't you won't be able to write to local files.", error.localizedDescription)
        }
    }

    var newlineExtraSpacePagaraphs: [String] {
        components(separatedBy: "\n")
            .flatMap { $0.components(separatedBy: "         ")}
            .filter { !$0.isEmpty }
    }

    var words: [String] {
        var words: [String] = []
        enumerateSubstrings(in: startIndex..., options: [.localized, .byWords]) { tag, _, _, _ in
            words.append(tag ?? "")
        }
        return words
    }

    /// Gets sentences from the string, then groups those sentences in order,
    /// not letting the total word count of those grouped sentences to exceed the maxWordCount.
    /// If a sentence is greater than the max word count, allow that sentence without joining with another. Do not split any sentence. Include all sentences.
    ///
    /// Input:
    /// self = "I am here. Go over there.  Apples are great. How are you? Cows are really really bad."
    /// maxWordCount = 3
    /// Output: ["I am here. ", "Go over there.  ", "Apples are great. ", "How are you? ",  "Cows are really really bad."]
    ///
    /// Input:
    /// self = "I am here. Go over there.  Apples are great. How are you? Cows are really really bad."
    /// maxWordCount = 8
    /// Output: ["I am here. Go over there.  ", "Apples are great. How are you? ",  "Cows are really really bad."]
    ///
    /// one liner!
    func sentencesGrouped(maxWordCount: Int = 100) -> [String] {
        sentences.reduce([String]()) { (result, sentence) -> [String] in
            guard let last = result.last else { return [sentence] }
            let lastWordCount = last.words.count
            let sentenceWordCount = sentence.words.count
            if lastWordCount + sentenceWordCount <= maxWordCount {
                return result.dropLast() + [last + " " + sentence]
            } else {
                return result + [sentence]
            }
        }
    }


    var sentences: [String] {
        var sentences: [String] = []
        enumerateSubstrings(in: startIndex..., options: [.localized, .bySentences]) { tag, _, _, _ in
            sentences.append(tag ?? "")
        }
        return sentences
    }

    /// Input:
    /// self = "I am here. Go over there.  Apples are great. How are you? Cows are really really bad."
    /// Output: ["I am here. ", "Go over there.  ", "Apples are great. ", "How are you? ",  "Cows are really really bad."]
    @available(macOS 10.13, *)
    @available(iOS 11.0, *)
    var linguisticTaggerSentences: [String] {
        let tagger = NSLinguisticTagger(tagSchemes: [.tokenType, .language, .lexicalClass, .nameType, .lemma], options: 0)
        let range = NSRange(location: 0, length: self.utf16.count)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
        tagger.string = self
        var sentences: [String] = []
        tagger.enumerateTags(in: range, unit: .sentence, scheme: .tokenType, options: options) { _, sentenceRange, _ in
            let sentence = (self as NSString).substring(with: sentenceRange)
            sentences.append(sentence)
        }
        return sentences
    }

    func hasOne(of strings: [String]) -> Bool {
        strings.first(where: { contains($0) }) != nil
    }

    var noNumbers: String {
        components(separatedBy: CharacterSet.decimalDigits).joined()
    }

    var fullRange: NSRange {
        NSRange(location: 0, length: utf16.count)
    }

    var range: Range<String.Index> {
        .init(uncheckedBounds: (lower: startIndex, upper: endIndex))
    }

    var nsRange: NSRange {
        NSRange(self.startIndex..., in: self)
    }

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

    /// Returns an empty string when there is no path.
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

    static var companyName: String { #function }
    static var inviteCode: String { #function }

    var isValidName: Bool { !hasSpecialCharacters() && count > 1 }
    var isValidPassword: Bool { count > 6 }
    var isValidCompanyName: Bool { isValidName }
    var isValidCode: Bool { count > 10 }


    var fileurl: URL? {
        URL(fileURLWithPath: self)
    }


    /// creates a local model url from a string.
    var localModelURL: URL {
        URL(fileURLWithPath: self + (self.contains(".mlmodel") ? "" : ".mlmodel"))
    }

    static let line = "\n-----------------\n\n"

    struct WriteToFileParams {
        let desktopPath: String
        let name: String
        let fileEnding: String
    }

    var numberLinted: String {
        replacing(["_", ",", " "])
    }

    var double: Double? { Double(numberLinted) }
    var decimal: Decimal? { Decimal(string: numberLinted) }

    func equalsUnderscoreSpaces(_ other: String) -> Bool {
        replacing(["_", ":"], with: " ") == other.replacing(["_", ":"], with: " ")
    }

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

    static func slashes(_ folders: String...) -> String {
        folders.joined(separator: "/")
    }

    static func slashes(_ folders: [String]) -> String {
        folders.joined(separator: "/")
    }

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

    func appendLineToURL(fileURL: URL) throws {
        try (self + "\n").appendToURL(fileURL: fileURL)
    }

    func appendToURL(fileURL: URL) throws {
        try data(using: String.Encoding.utf8)!.append(fileURL: fileURL)
    }

    func floatingPoint<T: FloatingPoint>() -> T? where T: LosslessStringConvertible { T(self) }

    static func bundlePath(for resource: String = "Content", of type: String = "json") -> Self {
        Bundle.main.path(forResource: resource, ofType: type)!
    }

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

    /// Expects the string to be in the format "name.type", for example "local.json"
    var localData: Data? {
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
    var paragraphs: [String] {
        components(separatedBy: "\n")
    }
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
}
