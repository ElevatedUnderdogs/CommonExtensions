//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation


public extension Decodable {
   init?(d: Data?) {
       guard let data = d,
             let s = Self(data) else { return nil }
       self = s
   }
}

public extension Decodable {
    init?(_ data: Data) {
        do {
            self = try JSONDecoder().decode(Self.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}
//
//public extension Decodable {
//    init?(_ data: Data) {
//        do {
//            self = try JSONDecoder().decode(Self.self, from: data)
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//}
