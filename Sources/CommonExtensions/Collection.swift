//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation


public extension Collection {

    var json: String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
            guard let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) else {
                print("Error: Can't create string with data. line: \(#line), file: \(#file)")
                return "{}"
            }
            return jsonString
        } catch let parseError {
            print("Error: json serialization error: \(parseError)")
            return "{}"
        }
    }

    var hasExactlyOne: Bool {
        return count == 1
    }

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

    subscript (safe intIndex: Int) -> Element? {
        self[safe: index(startIndex, offsetBy: intIndex)]
    }

    var third: Element? {
        self[safe: 2]
    }

    var secondToLast: Element? {
        self[safe: (count - 2)]
    }

    var thirdToLast: Element? {
        self[safe: (count - 3)]
    }

    var fourthToLast: Element? {
        self[safe: (count - 4)]
    }

    var fifthToLast: Element? {
        self[safe: (count - 5)]
    }

    func firstOfType<T>() -> T? {
        compactMap { $0 as? T }.first
    }

    subscript(safe index: Index) -> Element.Wrapped? where Element: AnyOptional {
        indices.contains(index) ? self[index].optional ?? nil : nil
    }
}

public extension Collection where Self: Encodable, Element: Codable {

    var jsonString: String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try? String(data: encoder.encode(self), encoding: .utf8)
    }
}

public extension Collection where Element: Equatable {

    func isEmptyOr(has element: Element) -> Bool {
        isEmpty || contains(element)
    }
}

// Hashable collection
public extension Collection where Element: Hashable {
    var allEqual: Bool { isEmpty ? true : Set(self).count == 1 }
   // var unique: [Element] { self.set.array }
}
