//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation


extension Decodable {
   init?(d: Data?) {
       guard let data = d,
             let s = Self(data) else { return nil }
       self = s
   }
}

extension Decodable {
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
//extension Decodable {
//    init?(_ data: Data) {
//        do {
//            self = try JSONDecoder().decode(Self.self, from: data)
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//}
