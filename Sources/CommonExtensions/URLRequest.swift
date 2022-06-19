//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension URLRequest {

    var deterministicHash: String {
        String((url.string + httpMethod.string + (httpBody?.sortedString ?? "") + (allHTTPHeaderFields?.sortedString ?? ""))
            .deterministicHash)
    }
}
