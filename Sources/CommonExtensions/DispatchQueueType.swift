//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

protocol DispatchQueueType {
    func async(execute work: @escaping @convention(block) () -> Void)
}

extension DispatchQueue: DispatchQueueType {
    public func async(execute work: @escaping @convention(block) () -> Void) {
         async(group: nil, qos: .unspecified, flags: [], execute: work)
     }
}

 final class DispatchQueueMock: DispatchQueueType {
    public func async(execute work: @escaping @convention(block) () -> Void) {
        work()
    }
}
