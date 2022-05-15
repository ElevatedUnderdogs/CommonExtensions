//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

import Foundation
import CoreLocation

extension CLLocationManager {

    func setFrequency(high: Bool) {
        if high {
            desiredAccuracy = kCLLocationAccuracyBest
            distanceFilter = kCLDistanceFilterNone
        } else {
            desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            distanceFilter = 30
        }
    }

//#if os(macOS, 10.12)
//    static var alwaysAuthorized: Bool {
//        CLLocationManager.authorizationStatus() == .authorizedAlways
//    }
//#endif

    func setFrequency(foreground: Bool) {
        if foreground {
            desiredAccuracy = 25
            distanceFilter = 25
        } else {
            desiredAccuracy = 150
            distanceFilter = 100
        }
    }

}
