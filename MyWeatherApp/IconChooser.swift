//
//  IconChooser.swift
//  WeatherApp
//
//  Created by Alexandr on 3/4/18.
//  Copyright © 2018 Alexandr. All rights reserved.
//

import UIKit

class IconChooser {
    static func chooseIcon(forDescription description: String) -> UIImage {
//        print(description)
        switch description {
        case "light rain":
            return UIImage(named: "raindrops")!
        case "moderate rain":
            return UIImage(named: "raindrops")!
        case "clear sky":
            return UIImage(named: "sunny")!
        case "few clouds":
            return UIImage(named: "clouds-1")!
        case "broken clouds":
            return UIImage(named: "clouds")!
        case "light snow":
            return UIImage(named: "snowing")!
        case "snow":
            return UIImage(named: "snowflake")!
        case "scattered clouds":
            return UIImage(named: "clouds")!
        case "overcast clouds":
            return UIImage(named: "clouds")!
        default:
            return UIImage(named: "rainbow")!
        }
    }
}
