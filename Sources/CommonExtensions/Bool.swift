//
//  File 3.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

extension Bool {

    var float: CGFloat { self ? 1 : 0 }
    var onOff: String { self ? "on" : "off" }
}


extension Bool {
    var negate: Bool { !self }

    var successStr: String {
        return self ? "successful" : "failed"
    }

    var yesNo: String {
        return self ? "yes" : "no"
    }

    var strInt: String {
        return self == true ? "1" : "0"
    }

    ///Returns 1 if true, 0 if false
    var int: Int {
        return self ? 1 : 0
    }
}


public extension Bool {

    var string: String {
        return self ? "true" : "false"
    }

    static func first(date first: Date, and second: Date, arewithinMonths: Int) -> Bool {
        second < first.adding(.month, value: arewithinMonths)
    }
}
