//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

extension Character {
    var asString: String {
        return String(self)
    }

    var isSpecialCharacter: Bool {
        return String(self).hasSpecialCharacters()
    }
}

extension Character {
    var isSemicolon: Bool { self == ";" }
}
