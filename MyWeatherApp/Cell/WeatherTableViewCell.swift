//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Alexandr on 3/1/18.
//  Copyright © 2018 Alexandr. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func commonInit(time : Date, place : String){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss dd.MM.YY"
        timeLabel.text = formatter.string(from: time)
        placeLabel.text = place
    }
    
}
