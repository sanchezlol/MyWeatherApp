//
//  DetailViewController.swift
//  MyWeatherApp
//
//  Created by Alexandr on 3/7/18.
//  Copyright © 2018 Alexandr. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var time : String!
    @IBOutlet weak var timeLabel: UILabel!
    var coordinates : String!
    @IBOutlet weak var coordinatesLabel: UILabel!
    var place : String!
    @IBOutlet weak var placeLabel: UILabel!
    var temperature : String!
    @IBOutlet weak var temperatureLabel: UILabel!
    var info : String!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timeLabel.text = time
        self.title = time
        self.coordinatesLabel.text = coordinates
        self.placeLabel.text = place
        self.temperatureLabel.text = temperature
        self.infoLabel.text = info
        self.icon.image = IconChooser.chooseIcon(forDescription: info)
    }

    func commonInit(time: String, coordinates: String, place: String, temperature: String, info: String) {
        self.time = time
        self.coordinates = coordinates
        self.place = place
        self.temperature = temperature
        self.info = info
    }
    

}
