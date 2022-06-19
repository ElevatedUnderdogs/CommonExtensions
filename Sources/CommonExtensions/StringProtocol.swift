//
//  File 14.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension StringProtocol {

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

    var data: Data { utf8.data }
    var rows: [SubSequence] { split(whereSeparator: \.isNewline) }
    var columns: [SubSequence] { split(whereSeparator: \.isSemicolon) }
    var csvToMatrix: [[SubSequence]] { rows.map(\.columns) }

    var matrix: [[String]] {
        components(separatedBy: "\n").map(\.csvRow)
    }

    var csvRow: [String] {
        components(separatedBy: ",")
    }
}
