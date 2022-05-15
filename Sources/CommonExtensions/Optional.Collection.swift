//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

extension Optional where Wrapped: Collection {
    /// returns true when not nil and not empty
    var hasContents: Bool {
        map { !$0.isEmpty } ?? false
    }
}
