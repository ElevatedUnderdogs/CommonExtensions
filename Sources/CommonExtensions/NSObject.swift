//
//  File 12.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

extension NSObject {

    @objc class var className: String {
        String(describing: self)
    }

    var className: String {
        String(describing: type(of: self))
    }

    class var bundle: Bundle {
        Bundle(for: self)
    }

    @objc func isUnitTestRunning() -> Bool {
        if let _ = NSClassFromString("XCTest") {
            print("\(#function) METHOD CALLED FROM UNIT TEST")
            return true
        }
        return false
    }
}
