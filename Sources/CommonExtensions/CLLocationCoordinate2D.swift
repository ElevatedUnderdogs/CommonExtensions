//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation
import CoreLocation


extension CLLocationCoordinate2D {

    var json: [String: String] {
        return [
            "latitude": latitude.string,
            "longitude": longitude.string,
        ]
    }

    static var currentLocation: CLLocationCoordinate2D? {
        return CLLocationManager().location?.coordinate
    }

    var nearby: CLLocationCoordinate2D? {
        guard let lat = CLLocationDegrees(exactly: latitude  + 0.01),
            let lon = CLLocationDegrees(exactly: longitude + 0.004) else {
                print("Error: Could not instantiate CllocationDegrees for some reason.")
                return nil
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }

#if os(iOS)
    static var thisLocation: CLLocationCoordinate2D? {
        guard CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways else { return nil }
        let locManager = CLLocationManager()
        let lat = locManager.location?.coordinate.latitude ?? 0.0,
        lon = locManager.location?.coordinate.longitude ?? 0.0
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
#endif

}
