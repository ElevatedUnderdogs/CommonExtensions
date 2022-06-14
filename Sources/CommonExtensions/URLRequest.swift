//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

//// local
//public extension URLRequest {
//
//    init?(_ urlString: String) {
//        let base = UserDefaults.baseUrlToUse
//        guard let url = URL(string: base) else { return nil }
//        self.init(url: url)
//    }
//
//    /// For standard URLRequests.
//    /// - Parameters:
//    ///   - url: The url for the request.
//    ///   - headers: headers to be passed to the request.
//    ///   - method: get or post.
//    init(
//        url: URL,
//        headers: [String: String],
//        method: HTTPMethod = .POST
//    ) {
//        self = URLRequest(url: url)
//        self.method = method
//        self.allHTTPHeaderFields = headers
//    }
//}

public extension URLRequest {

    var deterministicHash: String {
        String((url.string + httpMethod.string + (httpBody?.string ?? "")).deterministicHash)
    }
}
