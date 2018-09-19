//
//  BGGeocodingResult.swift
//  BattleOfGeocoding
//
//  Created by Samman Thapa on 9/19/18.
//  Copyright © 2018 Samman Labs. All rights reserved.
//

import Foundation

import CoreLocation

class BGGeocodingResult {
    var native: BGGeocoding?
    var googleMaps: BGGeocoding?
    var address: String
    
    init(_ address: String) {
        self.address = address
    }
    
    func getDistance() -> Int? {
        if native != nil && googleMaps != nil {
            let coordinate1 = CLLocation(latitude: native!.coordinates.latitude, longitude: native!.coordinates.longitude)
            let coordinate2 = CLLocation(latitude: googleMaps!.coordinates.latitude, longitude: googleMaps!.coordinates.longitude)
            return Int(coordinate1.distance(from: coordinate2))
        } else {
            return nil
        }
    }
    
}
