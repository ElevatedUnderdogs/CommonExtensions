//
//  File.swift
//  
//
//  Created by Scott Lydon on 6/13/22.
//

import Foundation

extension FileManager {
    func with(hash: String) throws -> URL {
        try url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathExtension(hash)
    }
}
