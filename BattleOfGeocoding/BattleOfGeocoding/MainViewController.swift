//
//  ViewController.swift
//  BattleOfGeocoding
//
//  Created by Samman Thapa on 9/19/18.
//  Copyright © 2018 Samman Labs. All rights reserved.
//

import UIKit
import PromiseKit

class MainViewController: UIViewController {
    var geocodingResults = [BGGeocodingResult]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.testAddresses()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testAddresses() {
        for address in self.getAddresses() {
            let geocodingResult = BGGeocodingResult(address)
            
            // init nativeGeocoding
            let nativeGeocoding = BGNativeGeocoding(address)
            
            // configure requests
            let geocodingRequest = BGGeocodingRequest(address: address)
            let geocodingService = BGGeocodingService(geocodingRequest)
            
            firstly {
                // use native geocoding
                nativeGeocoding.geoCode()
                }.then { (geocoding) -> Void in
                    geocodingResult.native = geocoding
                }.then {() -> Promise<BGGeocoding> in
                    // use google maps api for geocoding
                    geocodingService.getGeocoding()
                }.then { (geocoding) -> Void in
                    geocodingResult.googleMaps = geocoding
                }.always {() -> Void in
                    self.addGeocodingResult(geocodingResult)
                }.catch { (error) in
                    // manage error here
                    print ("error: ", error)
            }
        }
    }
}

extension MainViewController {
    func getAddresses() -> [String] {
        return [
            "10 Lombard Street, San Francisco",
            "7 Bay View, Ottawa",
            "London",
            "香港东路6号，5号楼，8号室",
            "Россия, 105066, г.Москва ул.",
            "Staraya Basmannaya Ulitsa, Moskva",
            "Potosí Bolivia",
            "Sikonge District",
            "Sheikh Khalifa Bin Saeed Street Dubai",
            "Baringin West Sumatra Indonesia",
            "Esrange",
            "Fv866 120 Skjervøy Norway"
        ]
    }
    
    private func addGeocodingResult(_ geocodingResult: BGGeocodingResult) {
        self.geocodingResults.append(geocodingResult)
        if geocodingResults.count == getAddresses().count {
            print ("Received all")
//            tableView.reloadData()
//            tableView.tableHeaderView = UIView()
        }
    }
}
