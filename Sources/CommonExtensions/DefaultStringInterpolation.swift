//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

extension DefaultStringInterpolation {
  mutating func appendInterpolation<T>(_ optional: T?) {
    appendInterpolation(String(describing: optional))
  }
}
