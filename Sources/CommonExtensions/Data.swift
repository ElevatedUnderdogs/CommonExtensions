//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension Data {

    var string: String {
        return map {String(format: "%02.2hhx", $0)}.joined()
    }

    mutating func appendString(string: String) {
        guard let data = string.data(
            using: String.Encoding.utf8,
            allowLossyConversion: true) else { return }
        append(data)
    }

    var serialized: [String: Any]? {
        do {
            if let json = try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] {
                return json
            }
        } catch let error {
            print("Error: ", error.localizedDescription, "for serializing: line: \(#line)")
        }
        return nil

    }

    var jsonDictionary: [String: Any]? {
        do {
            guard let unwrappedJson = try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] else {
                print("Warning: we were able to serialize the json but not cast it a [String: Any]...This would seem imposible without catching an error.")
                return nil
            }
            return unwrappedJson
        } catch let err {
            print("Error: ", err.localizedDescription, "for line: \(#line)")
            return nil
        }
    }

    func traditionalCodable<T: Codable>() -> T? {
        try? JSONDecoder().decode(T.self, from: self)
    }

    /// I think this should be fine...might need to roll it back..
    func codable<T: Codable>() -> T? {
        T(self)
    }
}

// MARK: Data
// public extension Data {

   // var string: String? { String(data: self, encoding: .utf8) }
//
//    var decodingHex: Data? {
//        string.map(\.decodingHex.data)
//    }

//    func decodedObject<T: Decodable>(using decoder: JSONDecoder = .iso8601) throws -> T {
//        try decoder.decode(T.self, from: self)
//    }
// }


// MARK: - Data
//public extension Data {
//    func decodedObject<T: Decodable>(using decoder: JSONDecoder = JSONDecoder()) throws -> T {
//        try decoder.decode(T.self, from: self)
//    }
//}

public extension Data {

   var ascii: String? {
       String(data: self, encoding: .ascii)
   }


    func string(encoding: String.Encoding = .utf8) -> String? {
        String(data: self, encoding: encoding)
    }

    var validJSON: String? {
        String(data: self, encoding: .utf8)
    }

//   func serialized() throws -> [String: Any]?  {
//       try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
//   }
//
//   func jsonDictionary() throws -> [String: Any] {
//       guard let unwrappedJson = try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] else {
//           throw GenericError(text: "Warning: we were able to serialize the json but not cast it a [String: Any]...This would seem imposible without catching an error.")
//       }
//       return unwrappedJson
//   }

   func append(fileURL: URL) throws {
       if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
           defer {
               fileHandle.closeFile()
           }
           fileHandle.seekToEndOfFile()
           fileHandle.write(self)
       }
       else {
           try write(to: fileURL, options: .atomic)
       }
   }

    var sortedString: String {
        let sorted = jsonDictionary?.sortedTuples
        let strings: [String] = sorted?.map { $0 + String(describing: $1) } ?? []
        let joined: String = strings.joined()
        return joined
    }
}
