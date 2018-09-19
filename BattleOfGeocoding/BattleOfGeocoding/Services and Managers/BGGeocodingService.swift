//
//  GeocodingRequest.swift
//  BattleOfGeocoding
//
//  Created by Samman Thapa on 9/19/18.
//  Copyright © 2018 Samman Labs. All rights reserved.
//

import Foundation

import Alamofire
import PromiseKit

class BGGeocodingService {
    var geocodingUrl = URLGenerator.geocodingApiUrlForPathString(path: "json")
    // request object that this service owns
    var geocodingRequest: BGGeocodingRequest
    
    init(_ geocodingRequest: BGGeocodingRequest) {
        self.geocodingRequest = geocodingRequest
    }
    
    func getGeocoding () -> Promise<BGGeocoding> {
        let parameters = geocodingRequest.toParameters()
        return Promise { fulfill, reject in
            Alamofire.request(geocodingUrl, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let json):
                    var geocoding: BGGeocoding? = nil
                    if let geocodingManagerDictionary = json as? NSDictionary {
                        let geocodingManager = BGGeocodingManager(geocodingDict: geocodingManagerDictionary)
                        geocoding = geocodingManager.serialize()
                    }
                    
                    if let geocoding = geocoding {
                        fulfill(geocoding)
                    } else {
                        reject(BGError.geocodingManagerDictionary)
                    }
                    
                case .failure(let error):
                    reject(error)
                }
            })
        }
    }
}
