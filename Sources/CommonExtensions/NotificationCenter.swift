//
//  File 13.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension NotificationCenter {

//    func joinChallenge(
//        competitionId: Int64,
//        teamId: Int64? = nil,
//        showSuccess: Bool = false
//    ) {
//        post(
//            name: .joinChallenge,
//            object: nil,
//            userInfo: [
//                String.competitionId: competitionId,
//                String.showSuccess: showSuccess,
//                String.teamId: teamId ?? 0,
//                String.showSuccessType: ShowSuccessType.youJoinedATeam
//            ]
//        )
//    }
//
//    func switchToChallenges() {
//        post(
//            name: .switchToCurrentChallenges,
//            object: nil,
//            userInfo: nil
//        )
//    }
//
//    func switchMyTeam(userInfo: [AnyHashable: Any]?) {
//        post(
//            name: .switchMyTeam,
//            object: nil,
//            userInfo: userInfo
//        )
//    }

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
