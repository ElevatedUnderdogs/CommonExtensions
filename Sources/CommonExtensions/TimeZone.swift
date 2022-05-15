//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension TimeZone {
    static let zeroSecondsFromGMT = Self(secondsFromGMT: 0)!
    static let saoPaulo = Self(identifier: "America/Sao_Paulo")!
    static let newYork = Self(identifier: "America/New_York")!
    static let losAngeles = Self(identifier: "America/Los_Angeles")!
    static var utc: TimeZone { TimeZone(identifier: "UTC")! }
}
