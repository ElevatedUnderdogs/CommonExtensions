//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension String.SubSequence {

    var int64: Int64? {
        NumberFormatter().number(from: String(self)) as? Int64
    }
//   Invalid redeclaration to string in Int extension.  
//    var string: String {
//        String(self)
//    }
}
