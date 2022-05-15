//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation



//// MARK: - JSONDecoder
//extension JSONDecoder {
//    static let decoder: JSONDecoder = {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        decoder.dateDecodingStrategy =  .newYorkISO8601
//        return decoder
//    }()
//}



// MARK: JSONDecoder
extension JSONDecoder {

   // static let iso8601 = JSONDecoder(dateDecodingStrategy: .iso8601)

    convenience init(dateDecodingStrategy: DateDecodingStrategy) {
        self.init()
        self.dateDecodingStrategy = dateDecodingStrategy
    }
}
