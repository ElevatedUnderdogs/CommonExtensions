//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation



extension RawRepresentable where RawValue: BinaryInteger {
    var double: Double { rawValue.double }
}
