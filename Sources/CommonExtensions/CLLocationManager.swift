//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation
import CoreLocation

public extension CLLocationManager {

    func setFrequency(high: Bool) {
        if high {
            desiredAccuracy = kCLLocationAccuracyBest
            distanceFilter = kCLDistanceFilterNone
        } else {
            desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            distanceFilter = 30
        }
    }


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
