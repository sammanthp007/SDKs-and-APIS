//
//  URLGenerator.swift
//  BattleOfGeocoding
//
//  Created by Samman Thapa on 9/19/18.
//  Copyright © 2018 Samman Labs. All rights reserved.
//

import Foundation

class URLGenerator {
    
    static let geocodingbaseUrl: String = "https://maps.googleapis.com/maps/api/geocode"
    
    class func geocodingApiUrlForPathString(path: String) -> String {
        
        return URLGenerator.geocodingbaseUrl + "/" + path
        
    }
    
}
