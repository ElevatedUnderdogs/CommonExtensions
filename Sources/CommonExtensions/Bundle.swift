//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation
import Security

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

    // MARK: - Sand box check
    // This is all needed to check if the app is in sandbox mode,
    // basically that the entitlements dictionary has Sandbox = YES

    var ob_createStaticCode: SecStaticCode? {
        var staticCode: SecStaticCode? = nil
        SecStaticCodeCreateWithPath(bundleURL as CFURL, SecCSFlags(), &staticCode)
        return staticCode
    }

    var ob_comesFromAppStore: Bool {
        guard let appStoreReceiptURL: URL = appStoreReceiptURL else { return false }
        return FileManager().fileExists(atPath: appStoreReceiptURL.path)
    }

    var ob_sandboxRequirement: SecRequirement? {
        var sandboxRequirement: SecRequirement?
        SecRequirementCreateWithString("entitlement[\"com.apple.security.app-sandbox\"] exists" as CFString, SecCSFlags(), &sandboxRequirement)
        return sandboxRequirement
    }

    var ob_isSandboxed: Bool {
        guard ob_codeSignState == .signatureValid,
              let staticCode = ob_createStaticCode else { return false }
        return SecStaticCodeCheckValidityWithErrors(
            staticCode,
            SecCSFlags(rawValue: kSecCSBasicValidateOnly),
            ob_sandboxRequirement,
            nil
        ) == errSecSuccess
    }

    var ob_codeSignState: OBCodeSignState {
        guard let staticCode: SecStaticCode = ob_createStaticCode else { return .error }
        switch SecStaticCodeCheckValidityWithErrors(staticCode, SecCSFlags(rawValue: kSecCSBasicValidateOnly), nil, nil) {
        case errSecSuccess: return .signatureValid
        case errSecCSUnsigned: return .unsigned
        case errSecCSSignatureFailed: return .signatureInvalid
        case errSecCSSignatureInvalid: return .signatureInvalid
        case errSecCSSignatureNotVerifiable: return .signatureNotVerifiable
        case errSecCSSignatureUnsupported: return .signatureUnsupported
        default: return .error
        }
    }
}
