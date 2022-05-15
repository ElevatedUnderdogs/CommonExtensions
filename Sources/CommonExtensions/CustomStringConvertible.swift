//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension CustomStringConvertible {

    var description: String {
        guard let displayStyle = Mirror(reflecting: self).displayStyle else {
            return "Could not reflect the type"
        }
        var description = "***** \(type(of: self)) *****\n"
        let selfMirror = Mirror(reflecting: self)
        switch displayStyle {
        case .enum:
            description += "case: \(selfMirror.description))"
        default:
            for child in selfMirror.children {
                if let propertyName = child.label {
                    if let array = child.value as? Array<Any>  {
                        description += "\(propertyName): \(array.prefix(5))...\n"
                    } else if let dictionary = child.value as? Dictionary<AnyHashable, Any> {
                        description += "\(propertyName): \(dictionary.prefix(5))...\n"
                    } else {
                        description += "\(propertyName): \(child.value)\n"
                    }
                }
            }
        }
        return description
    }
}
