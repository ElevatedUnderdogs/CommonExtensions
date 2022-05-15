//
//  File 18.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension UserDefaults {

//    func search(for key: String) -> Search? {
//        retrieve(for: key)
//    }

//    func retrieve<Value: Codable>(for key: String) -> Value? {
//        /*
//         if let data = UserDefaults.standard.object(forKey: key) as? Data,
//             let user = try? JSONDecoder().decode(T.self, from: data) {
//             return user
//
//         }
//
//         return  defaultValue
//         */
//        guard let data = object(forKey: key) as? Data else { return nil }
//        do {
//            return try JSONDecoder().decode(Value.self, from: data)
//        } catch {
//            assert(!debugModeOn, error.localizedDescription)
//            return nil
//        }
//    }

//    func store<Value: Codable>(value: Value, for key: String) {
//        /*
//         if let encoded = try? JSONEncoder().encode(newValue) {
//             UserDefaults.standard.set(encoded, forKey: key)
//         }
//         */
//        do {
//            set(try JSONEncoder().encode(value), forKey: key)
//        } catch {
//            assert(!debugModeOn, error.localizedDescription)
//        }
//    }
}


//public extension Dictionary {
//    mutating func merge(dict: [Key: Value]){
//        for (k, v) in dict {
//            updateValue(v, forKey: k)
//        }
//    }
//}

public extension Array {

    mutating func removeLastSafe() -> Element? {
        print("The count is: \(count)")
        if count > 0 {
            return removeLast()
        }
        return nil
    }
}

public extension Int {
    var string: String {
        String(self)
    }
}

public extension String {


//    var url: URL? {
//        URL(string: self)
//    }

    func hasOne(of strings: [String]) -> Bool {
        strings.first(where: { contains($0) }) != nil
    }

    var noNumbers: String {
        components(separatedBy: CharacterSet.decimalDigits).joined()
    }


    var fullRange: NSRange {
        NSRange(location: 0, length: utf16.count)
    }
//
//    var int: Int? {
//        Int(self)
//    }
//
//    func matches(for regex: String) -> [String] {
//        do {
//            return try NSRegularExpression(pattern: regex)
//                .matches(in: self, range: range)
//                .map { String(self[Range($0.range, in: self)!]) }
//        } catch let error {
//            print("invalid regex: \(error.localizedDescription)")
//            return []
//        }
//    }

    var range: NSRange {
        NSRange(self.startIndex..., in: self)
    }


}


public extension URL {
    var request: URLRequest? {
        URLRequest(url: self)
    }
}

//public extension String.SubSequence {
//
//    var string: String {
//        String(self)
//    }
//}
//
//public extension Collection {
//
//    /// Returns the element at the specified index if it is within bounds, otherwise nil.
//    subscript (safe index: Index) -> Element? {
//        indices.contains(index) ? self[index] : nil
//    }
//}
//
