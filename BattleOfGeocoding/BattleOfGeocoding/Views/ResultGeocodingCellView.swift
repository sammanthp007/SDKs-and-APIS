//
//  ResultGeocodingCellView.swift
//  BattleOfGeocoding
//
//  Created by Samman Thapa on 9/19/18.
//  Copyright © 2018 Samman Labs. All rights reserved.
//

import UIKit

class ResultGeocodingCellView: UITableViewCell {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var iosStatusLabel: UILabel!
    @IBOutlet weak var iosLatitudeLabel: UILabel!
    @IBOutlet weak var iosLongitudeLabel: UILabel!
    @IBOutlet weak var googleStatusLabel: UILabel!
    @IBOutlet weak var googleLatitudeLabel: UILabel!
    @IBOutlet weak var googleLongitudeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
