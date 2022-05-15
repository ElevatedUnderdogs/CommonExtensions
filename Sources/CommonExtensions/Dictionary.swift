//
//  File 8.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

extension Dictionary {

    static func + (lhs: Self, rhs: Self) -> Self {
        var new: Self = lhs
        new.merge(dict: rhs)
        return new
    }

    mutating func merge(dict: [Key: Value]) {
        for (key, value) in dict {
            updateValue(value, forKey: key)
        }
    }

    /// returns true when not nil and not empty
    var hasContents: Bool {
        !keys.isEmpty
    }
}


//extension Dictionary where Key == UIImagePickerController.InfoKey, Value == Any {
//
//    var stringAnyDictionary: [String: Any] {
//        return [String: Any](uniqueKeysWithValues: map {key, value in (key.rawValue, value)})
//    }
//}


extension Dictionary  {

    var hasElements: Bool {
        for (_, _) in self {
            return true
        }
        return false
    }
}


extension Dictionary where Value == Int {

    mutating func replace(oldValue: Int, newValue: Int) {
        var keys: [Key] = []
        for (key, value) in self where value == oldValue {
            keys.append(key)
        }
        for key in keys {
            self[key] = newValue
        }
    }

    mutating func removePairsWith(oldValue: Int) {
        var keys: [Key] = []
        for (key, value) in self where value == oldValue {
            keys.append(key)
        }
        for key in keys {
            self[key] = nil
        }
    }
}


extension Dictionary where Key ==  String, Value == Double {

    var json: [String: String] {
        return mapValues { String($0) }
    }
}


extension Dictionary where Key == String, Value == Any {
    var success: Bool {
        guard let success = self["success"] as? Int else { return false }
        return success.boolValue
    }

    var databaseTimeLapse: Float? {
        return self["databaseTimeLapse"] as? Float
    }

    var serversideOnlyTimeLapse: Float? {
        return self["serversideOnlyTimeLapse"] as? Float
    }

    var emailIsAvailable: Bool {
        return true
    }

    var userIsBlocked: Bool {
        return true
    }


    func value<T>(for key: String) -> T? {
        if let value = self[key] as? T {
            return value
        } else {
            print("Warning: parsing failed for key: \(key)")
            return nil
        }
    }
}


public typealias DictionaryAction = ([String: Any]) -> Void


func += <K, V> (left: inout [K:V], right: [K:V]) {
    for (k, v) in right {
        left[k] = v
    }
}

extension Dictionary where Key == String, Value == String {
//    static func forAccess(
//        _ token: String = Bundle.td_AccessToken,
//        moreHeaders: [String: String] = [:]
//    ) -> Self {
//        ["Authorization": "Bearer " + token].mergeReplacingCurrent(with: moreHeaders)
//    }

    var stringFile: String {
        map { "\"" + $0.0  + "\" = \"" +  $0.1 + "\";" }.joined(separator: "\n")
    }
}



extension Dictionary where Key == String, Value == Any {

//    var data: Data? {
//        try? NSKeyedArchiver.archivedData(
//            withRootObject: self,
//            requiringSecureCoding: false
//        )
//    }
//
//    init(
//        _ data: Data?,
//        _ urlResponse: URLResponse?,
//        _ error: Error?,
//        _ line: Int,
//        _ file: String,
//        _ urlString: String
//    ) throws {
//        guard let data = data else {
//            throw GenericError(text: "ERROR: data was nil for the call from: \(urlString), ")
//        }
//        do {
//            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
//                throw GenericError(text: "Warning: we were able to serialize the json but not cast it a [String: Any]...This would seem imposible without catching an error.")
//            }
//            self = json
//        } catch {
//            throw GenericError(text: "file: \(file) \n" + "line: \(line)" + error.localizedDescription + "for \(urlString)")
//        }
//    }

    var asJSON: String? {
        try? JSONSerialization.data(
            withJSONObject: self,
            options: []
        ).ascii
    }

    static func parameters(
        _ refreshToken: String,
        _ apiKey: String = "FMUIJZGTI7IV08OAEIMTXGA6Y9TNRYEJ"
    ) -> Self {
        [
            "grant_type":"refresh_token",
            "refresh_token": refreshToken,
            "access_type":"offline",
            "client_id": apiKey
        ]
    }
}


extension Dictionary {

    func mergeReplacingCurrent(with dict: [Key: Value]) -> Self {
        merging(dict) { $1 }
    }

    var queryString: String {
        reduce("") { $0 + "\($1.key)=\($1.value)&"}.dropLast().string
    }
}

//extension Dictionary where Key: DoubleConvertible, Value == Double {
//
//    var score: Double {
//        reduce(0) { $0 + $1.key.double * $1.value }
//    }
//}

extension Dictionary where Value == Double {

    mutating func add(_ value: Double, for key: Key) {
        self[key] = self[key].zeroIfNil + value
    }
}
extension Dictionary where Value == Decimal {

    mutating func add(_ value: Decimal, for key: Key) {
        self[key] = value + self[key].zeroIfNil
    }
}

//extension Dictionary where Key == String, Value == Double {
//    var score: Double {
//        reduce(0) { $0 + ($1.key.trend?.double ?? .zero) * $1.value }
//    }
//}


extension Dictionary where Key: Comparable {
    var sortedTuples: [(Key, Value)] {
        keys.sorted().map { ($0, self[$0]!) }
    }
}
