//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension LosslessStringConvertible {
    var string: String { .init(self) }
}
