//
//  OBCodeSignState.swift
//  
//
//  Created by Scott Lydon on 6/18/22.
//

import Foundation

public enum OBCodeSignState: Int {
    case unsigned = 1
    case signatureValid
    case signatureInvalid
    case signatureNotVerifiable
    case signatureUnsupported
    case error
}
