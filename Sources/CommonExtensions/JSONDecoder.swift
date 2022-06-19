//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation


// MARK: JSONDecoder
public extension JSONDecoder {

  //  @available(macOS 10.12, *)
  //  static let iso8601 = JSONDecoder(dateDecodingStrategy: .iso8601)

    convenience init(dateDecodingStrategy: DateDecodingStrategy) {
        self.init()
        self.dateDecodingStrategy = dateDecodingStrategy
    }
}
