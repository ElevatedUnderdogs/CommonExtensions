//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public typealias Crossword = [[String]]

public extension Array where Element == [String] {

    typealias EnumerateAction = (Coordinate, String) -> Void

    /// O(1)
    func isOutOfbounds(_ coord: Coordinate) -> Bool {
        return isOutOfRowBounds(coord.x) || isOutOfColumnbounds(coord.y)
    }

    /// O(1)
    func isOutOfRowBounds(_ x: Int) -> Bool {
        return x < 0 || x >= self[0].count
    }

    /// O(1)
    func isOutOfColumnbounds(_ y: Int) -> Bool {
        y < 0 || y >= self.count
    }

    /// O(1)
    subscript(safe coord: Coordinate) -> String? {
        get {
            return isEmpty || isOutOfbounds(coord) ? nil : self[coord.y][coord.x]
        }
    }

    /// O(1)
    func directions(for nextChar: String, from coord: Coordinate) -> [Direction] {
        var matches: [Direction] = []
        for direction in Direction.allCases {
            let newCoordinate = coord.next(in: direction)
            if let string = self[safe: newCoordinate],
                string == nextChar {
                matches.append(direction)
            }
        }
        return matches
    }

    /// whichever is lesser: O(k) where k is the character count of the inputted word or O(L) where L is the greater of the two: matrix Row count and matrix column count.
    func has(_ word: String, in direction: Direction, from coord: Coordinate) -> Bool {
        var coord = coord
        for char in word {
            guard let letter = self[safe: coord],
                letter == String(char) else {
                return false
            }
            coord = coord.next(in: direction)
        }
        return true
    }

    /// whichever is lesser: O(k) where k is the character count of the inputted word or O(L) where L is the greater of the two: matrix Row count and matrix column count.
    mutating func paste(_ word: String, in direction: Direction, from coord: Coordinate) {
        var coord = coord
        for char in word {
            guard self[safe: coord] != nil else {
                return
            }
            self[coord.y][coord.x] = String(char)
            coord = coord.next(in: direction)
        }
    }

    /// O(N) where N is the total number of cells in the inputted Crossword matrix
    init(emptyCopy prior: Crossword) {
        var new: Crossword = []
        for (rowIndex, row) in prior.enumerated() {
            new.append([])
            for _ in row {
                new[rowIndex].append("")
            }
        }
        self = new
    }

    /// O(N) where N is the total number of cells in this matrix
    func matrixEnumerated(completion: EnumerateAction) {
        for (y, row) in enumerated() {
            for (x, charstring) in row.enumerated() {
                completion(Coordinate(x: x, y: y), charstring)
            }
        }
    }

    /// whichever is lesser: O(k) where k is the character count of the inputted word or O(L) where L is the greater of the two: matrix Row count and matrix column count.
    @discardableResult
    mutating func pasteIfHas(_ word: String, in crossword: Crossword, in direction: Direction, from coord: Coordinate) -> Bool {
        let hasWord = crossword.has(word, in: direction, from: coord)
        if crossword.has(word, in: direction, from: coord) {
            paste(word, in: direction, from: coord)
        }
        return hasWord
    }

    ///  Key
    ///   N:  is the number of cells in the matrix
    ///   W: is the number of inputted words
    ///   K: is the number of characters in each of those words
    ///  Worst case: O(N*W*K)
    ///  Best Case: O(N)
    /// If no words are given, an empty matrix will be returned with an equal size as the inputted matrix.  If an empty matrix is given an empty matrix will be returned.
    func answer(for words: [String]) -> Crossword {
        var result = Crossword(emptyCopy: self)
        words.forEach { word in
            matrixEnumerated { coord, charstring in
                guard word[0] == charstring else {
                    return
                }
                if word.count == 1 {
                    result[coord.y][coord.x] = word[0]
                    return
                }
                for direction in directions(for: word[1], from: coord) {
                    result.pasteIfHas(word, in: self, in: direction, from: coord)
                }
            }
        }
        return result
    }

    /// O(N) where N is the number of cells in this matrix.
    func prettyPrint() {
        for row in self {
            print(row)
        }
    }

}
