//
//  WeatherTableViewCell.swift
//  Prepare-For-Rain
//
//  Created by Henry Dinhofer on 11/26/16.
//  Copyright © 2016 Henry Dinhofer. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var percentChanceLabel: UILabel!
    @IBOutlet weak var intensityRainLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
