//
//  BGGeocoding.swift
//  BattleOfGeocoding
//
//  Created by Samman Thapa on 9/19/18.
//  Copyright © 2018 Samman Labs. All rights reserved.
//

import Foundation
import MapKit

class BGGeocoding {
    
    var coordinates: CLLocationCoordinate2D
    var name: String?
    var formattedAddress: String?
    var boundNorthEast: CLLocationCoordinate2D?
    var boundSouthWest: CLLocationCoordinate2D?
    
    init(coordinates: CLLocationCoordinate2D) {
        self.coordinates = coordinates
    }
    
}
