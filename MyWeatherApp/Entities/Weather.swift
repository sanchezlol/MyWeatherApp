//
//  Weather.swift
//  WeatherApp
//
//  Created by Alexandr on 2/26/18.
//  Copyright © 2018 Alexandr. All rights reserved.
//

import Foundation

struct Weather : Codable {
    let coord : Locations?
    struct Locations : Codable {
        let lon : Double
        let lat : Double
    }
    let weather : Array<WeatherItem>?
    struct WeatherItem : Codable {
        let description : String
    }
    let main : MainItem?
    struct MainItem : Codable {
        let temp_min : Double
        let temp_max : Double
    }
    let sys : WeatherInfoItem?
    struct WeatherInfoItem : Codable {
        let country : String?
    }
    let name : String?
}


