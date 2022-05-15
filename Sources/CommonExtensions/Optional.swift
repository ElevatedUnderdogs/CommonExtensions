//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation


extension Optional where Wrapped: Numeric {

    /// Returns 0 when this is nil.
    var orZero: Wrapped {
        self ?? 0
    }
}

extension Optional where Wrapped: Numeric, Wrapped: Comparable {

    var plurality: String {
        orZero > 1 ? "s" : ""
    }
}

extension Optional {

    // casts to Any
    var any: Any {
        self as Any
    }
}


extension Optional where Wrapped: AdditiveArithmetic {
    var isEmpty: Bool {
        self == .zero || self == nil
    }
}


extension Optional where Wrapped == String {

    @discardableResult
    static postfix func *~(expression: Self) -> String {
        expression ?? "nil"
    }
}

extension Optional {

    func onlyPrintIfnotNil(preface: String = "") {
        if let wrapped = self {
            print(preface, " ", wrapped)
        }
    }

    func onlyPrintIfNil(_ text: String) {
        if self == nil {
            print(text)
        }
    }

    static func map<Return, First, Second>(
        _ first: First?, _ second: Second?, _ action: (First, Second) -> Return
    ) -> Return? {
        guard let first = first, let second = second else { return nil }
        return action(first, second)
    }

    static func map<Return, First, Second, Third>(
        _ first: First?, _ second: Second?, _ third: Third?, _ action: (First, Second, Third) -> Return
    ) -> Return? {
        guard let first = first, let second = second, let third = third else { return nil }
        return action(first, second, third)
    }
}

extension Optional where Wrapped: CustomStringConvertible {

    /// Provides a string representation of the wrapped value, "nil" if nil.
    var string: String {
        map { String(describing: $0) } ?? "nil"
    }
}

extension Optional where Wrapped: RawRepresentable, Wrapped.RawValue == String {
    /// unwraps a string and returns "nil" if nil.
    var string: String {
        map(\.rawValue) ?? "nil"
    }
}

extension Optional where Wrapped: AdditiveArithmetic {
    var zeroIfNil: Wrapped {
        self ?? .zero
    }
}

extension Optional {
    func flatten() -> Wrapped? {
        return self
    }

    func flatten<T>() -> T? where Wrapped == T? {
        return map { $0.flatten() } ?? nil
    }

    func flatten<T>() -> T? where Wrapped == T?? {
        return map { $0.flatten() } ?? nil
    }

    func flatten<T>() -> T? where Wrapped == T??? {
        return map { $0.flatten() } ?? nil
    }

    func flatten<T>() -> T? where Wrapped == T???? {
        return map { $0.flatten() } ?? nil
    }

    func flatten<T>() -> T? where Wrapped == T????? {
        return map { $0.flatten() } ?? nil
    }
}

precedencegroup Chaining {
    associativity: left
}

protocol AnyOptional {
    associatedtype Wrapped
    var optional: Optional<Wrapped> { get }
}

extension Optional: AnyOptional {
    var optional: Optional<Wrapped> { self }
}

// MARK: optional
extension AnyOptional where Wrapped: LosslessStringConvertible  {
    var string: String {  optional?.string ?? "nil" }
}

// MARK: double optional
extension AnyOptional where Wrapped: AnyOptional, Wrapped.Wrapped: LosslessStringConvertible {
    var string: String { optional?.string ?? "nil" }
}

// MARK: triple optional
extension AnyOptional where Wrapped: AnyOptional,
                            Wrapped.Wrapped: AnyOptional,
                            Wrapped.Wrapped.Wrapped: LosslessStringConvertible  {
    var string: String {  optional?.string ?? "nil" }
}
