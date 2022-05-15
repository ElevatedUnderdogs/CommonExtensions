//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

extension CaseIterable {

    static var random: Self {
        // Why did you try to get a random case from an enum without any cases?
        allCases.randomElement()!
    }
}
