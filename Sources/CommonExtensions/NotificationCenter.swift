//
//  File 13.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension NotificationCenter {

    func addObserver(
        for name: NSNotification.Name,
        object: Any? = nil,
        queue: OperationQueue? = nil,
        using notificationAction: @escaping (Notification) -> Void
    ) {
        addObserver(
            forName: name,
            object: object,
            queue: queue,
            using: notificationAction
        )
    }

    func addObservers(
        for names: NSNotification.Name...,
        object: Any? = nil,
        queue: OperationQueue? = nil,
        using notificationAction: @escaping (Notification) -> Void
    ) {
        for name in names {
            addObserver(
                forName: name,
                object: object,
                queue: queue,
                using: notificationAction
            )
        }
    }
}
