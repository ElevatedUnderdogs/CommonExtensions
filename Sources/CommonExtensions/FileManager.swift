//
//  File.swift
//  
//
//  Created by Scott Lydon on 6/13/22.
//

import Foundation

public extension FileManager {

    func desktop() throws -> URL {
        try url(
            for: .desktopDirectory,
            in: .allDomainsMask,
            appropriateFor: nil,
            create: false
        )
    }

    func with(hash: String) throws -> URL {
        try url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathExtension(hash)
    }
}
