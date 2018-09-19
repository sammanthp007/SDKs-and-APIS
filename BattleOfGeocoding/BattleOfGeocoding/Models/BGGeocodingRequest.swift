//
//  GeocodingRequest.swift
//  BattleOfGeocoding
//
//  Created by Samman Thapa on 9/19/18.
//  Copyright © 2018 Samman Labs. All rights reserved.
//

import Foundation

import Alamofire

class BGGeocodingRequest {
    var address: String
    
    init(address: String) {
        self.address = address
    }
    
    func toParameters() -> Parameters {
        let parameters: Parameters = [
            "address": self.address,
            "key": "AIzaSyCPI33xuqQQ-xWgULJUMxU16YKb6a5kBhY"
        ]
        
        return parameters
    }
}
