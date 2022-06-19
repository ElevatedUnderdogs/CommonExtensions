//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension OutputStream {

    func send(message: String) {
        guard let data = message.data(using: .utf8) else {
            print("ERROR: could not convert string to data")
            return
        }
        data.withUnsafeBytes {
            guard let pointer = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                print("Error joining chat")
                return
            }
            write(pointer, maxLength: data.count)
        }
    }
}
