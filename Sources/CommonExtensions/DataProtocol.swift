//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension DataProtocol {

   var string: String? {
       String(bytes: self, encoding: .utf8)
   }
}
