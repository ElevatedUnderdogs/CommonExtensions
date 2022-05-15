//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

// MARK: - Range extension for convert range to NSRange
extension RangeExpression where Bound == String.Index {
    func nsRange<S: StringProtocol>(in string: S) -> NSRange { .init(self, in: string) }
}
