//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation
import XCTest

public extension XCTest {
    func XCTAssertOrPrint(_ assertion: Bool, _ message: String) {
        if assertion {
            print(message)
        } else {
            XCTAssert(assertion, message)
        }
    }
}
