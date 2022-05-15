//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension Float {

    var int: Int {
        Int(self)
    }

    var string: String {
        String(format: "%.2f", self)
    }
}
