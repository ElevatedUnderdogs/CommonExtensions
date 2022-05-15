//
//  File 14.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

extension StringProtocol {

    var int: Int? { Int(self) }

    var bool: Bool? {
        ["true", "t", "yes", "y", "1"].contains(lowercased())
    }

    /// Checks if it has the string and lowercases both so capitalization is independent
    /// - Parameter other: string contained
    /// - Returns: true if it contains the string regardless of capitalization.
    func contains<T: StringProtocol>(other: T) -> Bool {
        lowercased().contains(other.lowercased())
    }

    /// Useful for search.
    /// - Parameter other: string contained
    /// - Returns: false if the string is not contained and not "" nor nil.
    func containsOrEmpty<T: StringProtocol>(other: T?) -> Bool {
        other.map { $0 == "" ? true : contains(other: $0) } ?? true
    }
}

// MARK: StringProtocol
extension StringProtocol {

    var data: Data { utf8.data }

//    var decodingHexaUnicode: String {
//        applyingTransform(.unicodeToAny, reverse: false)!
//    }
//
//    var encodingHexaUnicode: String {
//        applyingTransform(.anyToUnicode, reverse: false)!
//    }
//
//    var decodingHex: String {
//        applyingTransform(.hexToAny, reverse: false)!
//    }
//
//    var encodingHexa: String {
//        applyingTransform(.anyToHex, reverse: false)!
//    }
}


extension StringProtocol {
    var rows: [SubSequence] { split(whereSeparator: \.isNewline) }
    var columns: [SubSequence] { split(whereSeparator: \.isSemicolon) }
    var csvToMatrix: [[SubSequence]] { rows.map(\.columns) }
}

extension StringProtocol {

    var matrix: [[String]] {
        components(separatedBy: "\n").map(\.csvRow)
    }

    var csvRow: [String] {
        components(separatedBy: ",")
    }
}
