//
//  BGNativeGeocoding.swift
//  BattleOfGeocoding
//
//  Created by Samman Thapa on 9/19/18.
//  Copyright © 2018 Samman Labs. All rights reserved.
//

import Foundation

import MapKit
import PromiseKit

class BGNativeGeocoding {
    var address: String
    lazy var geocoder = CLGeocoder()
    
    init(_ address: String) {
        self.address = address
    }
    
    func geoCode() -> Promise<BGGeocoding> {
        return Promise { fulfill, reject in
            firstly {
                self.geocodeAddressString()
                }.then { (placemarks) -> Promise<BGGeocoding> in
                    self.processResponse(withPlacemarks: placemarks)
                }.then { (geocoding) -> Void in
                    fulfill(geocoding)
                }.catch { (error) in
                    reject(error)
            }
        }
    }
    
    // Mark: - Get an array of CLPlacemark
    private func geocodeAddressString() -> Promise<[CLPlacemark]> {
        return Promise { fulfill, reject in
            geocoder.geocodeAddressString(address) { (placemarks, error) in
                if (error != nil) {
                    reject(error!)
                } else {
                    fulfill(placemarks!)
                }
            }
        }
    }
    
    // Mark: - Convert an array of CLPlacemark to a Geocoding Object
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?) -> Promise<BGGeocoding> {
        return Promise { fulfill, reject in
            
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                let geocoding = BGGeocoding(coordinates: location.coordinate)
                fulfill(geocoding)
            } else {
                reject( BGError.noMatchingLocation)
            }
        }
    }
}
