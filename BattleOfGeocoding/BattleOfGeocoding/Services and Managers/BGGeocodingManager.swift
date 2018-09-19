//
//  BGGeocodingManager.swift
//  BattleOfGeocoding
//
//  Created by Samman Thapa on 9/19/18.
//  Copyright © 2018 Samman Labs. All rights reserved.
//

import Foundation
import MapKit

class BGGeocodingManager {
    var geocoding: BGGeocoding? = nil
    var geocodingDict: NSDictionary
    
    required init (geocodingDict: NSDictionary) {
        self.geocodingDict = geocodingDict
    }
    
    // Mark:- Geocoding serialize
    func serialize() -> BGGeocoding? {
        if let resultArray = self.geocodingDict["result"] as? NSArray {
            if let resultDict = resultArray[0] as? [String: AnyObject] {
                // get coordinates
                var cooridnates = CLLocationCoordinate2D()
                if let value = resultDict["geometry"] as? NSDictionary {
                    if let location = value["location"] as? [String:AnyObject] {
                        let latitude = CLLocationDegrees(location["lat"]?.floatValue ?? 0.0)
                        let longitude = CLLocationDegrees(location["lng"]?.floatValue ?? 0.0)
                        cooridnates.latitude = latitude
                        // TODO: figure out why this is being converted to CLLocationDegrees twice
                        cooridnates.longitude = CLLocationDegrees(longitude)
                    }
                }
                
                if cooridnates.latitude != 0.0 {
                    let geocoding = BGGeocoding(coordinates: cooridnates)
                    
                    // get name of location
                    if let value = resultDict["address_components"] as? NSArray {
                        if let component = value[0] as? [String:Any] {
                            geocoding.name = component["long_name"] as? String
                        }
                    }
                    
                    // get formattedAddress
                    if let value = resultDict["formatted_address"] as? String {
                        geocoding.formattedAddress = value
                    }
                    
                    // get bounds, whatever that means
                    if let geometry = resultDict["geometry"] as? [String:Any] {
                        
                        if let bounds = geometry["bounds"] as? [String:AnyObject] {
                            if let value = bounds["northeast"] as? [String:AnyObject] {
                                geocoding.boundNorthEast = CLLocationCoordinate2D(latitude: CLLocationDegrees(value["lat"]!.floatValue), longitude: CLLocationDegrees(value["lng"]!.floatValue))
                            }
                            
                            if let value = bounds["southwest"] as? [String:AnyObject] {
                                geocoding.boundSouthWest = CLLocationCoordinate2D(latitude: CLLocationDegrees(value["lat"]!.floatValue), longitude: CLLocationDegrees(value["lng"]!.floatValue))
                            }
                        }
                    }
                    return geocoding
                } else {
                    return nil
                }
            }
        }
        return nil
    }
}
