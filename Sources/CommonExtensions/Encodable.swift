//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension Encodable {

    var asDictionary: [String: Any]? {
      guard let data = try? JSONEncoder().encode(self) else { return nil }
      return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}


public extension Encodable {

    /// Converting object to postable dictionary
    /// SLashes are added when printing an optional string
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try encoder.encode(self)
        let object = try JSONSerialization.jsonObject(with: data)
        guard let json = object as? [String: Any] else {
            let context = DecodingError.Context(codingPath: [], debugDescription: "Deserialized object is not a dictionary")
            throw DecodingError.typeMismatch(type(of: object), context)
        }
        return json
    }

    /// SLashes are added when printing an optional string
    func stringified() throws -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return String(data: try encoder.encode(self), encoding: .utf8)
    }

    /// SLashes are added when printing an optional string
    func stringString() throws -> [String: String] {
        try toDictionary() as? [String: String] ?? [:]
    }
}
