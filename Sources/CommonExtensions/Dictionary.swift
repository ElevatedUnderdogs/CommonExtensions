//
//  File 8.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension Dictionary {

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

    var hasElements: Bool {
        for (_, _) in self {
            return true
        }
        return false
    }

    func mergeReplacingCurrent(with dict: [Key: Value]) -> Self {
        merging(dict) { $1 }
    }

    var queryString: String {
        reduce("") { $0 + "\($1.key)=\($1.value)&"}.dropLast().string
    }
}


public extension Dictionary where Value == Int {

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


public extension Dictionary where Key ==  String, Value == Double {

    var json: [String: String] {
        mapValues { String($0) }
    }
}

public typealias DictionaryAction = ([String: Any]) -> Void


func += <K, V> (left: inout [K:V], right: [K:V]) {
    for (k, v) in right {
        left[k] = v
    }
}

public extension Dictionary where Key == String, Value == String {

    var stringFile: String {
        map { "\"" + $0.0  + "\" = \"" +  $0.1 + "\";" }.joined(separator: "\n")
    }


    var sortedString: String {
        let strings: [String] = sortedTuples.map { $0 + String(describing: $1) }
        let joined: String = strings.joined()
        return joined
    }
}

public extension Dictionary where Key == String, Value == Any {

    var asJSON: String? {
        try? JSONSerialization.data(
            withJSONObject: self,
            options: []
        ).ascii
    }

    var success: Bool {
        guard let success = self["success"] as? Int else { return false }
        return success.boolValue
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


public extension Dictionary where Value == Double {

    mutating func add(_ value: Double, for key: Key) {
        self[key] = self[key].zeroIfNil + value
    }
}

public extension Dictionary where Value == Decimal {

    mutating func add(_ value: Decimal, for key: Key) {
        self[key] = value + self[key].zeroIfNil
    }
}

public extension Dictionary where Key: Comparable {
    var sortedTuples: [(Key, Value)] {
        keys.sorted().map { ($0, self[$0]!) }
    }
}
