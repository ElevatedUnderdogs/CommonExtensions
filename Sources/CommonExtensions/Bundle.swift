//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension Bundle {

    var displayName: String? {
        object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }

    static var appName: String? {
        Bundle.main.infoDictionary?["CFBundleName"] as? String
    }
    
    static var version: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var appName: String {
        object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
            object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
    }
}
