//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Alexandr on 3/1/18.
//  Copyright © 2018 Alexandr. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherObject : Object {
    @objc dynamic var temperature : String = "unknown"
    @objc dynamic var info : String = "unknown"
    @objc dynamic var place : String = "unknown"
    @objc dynamic var latitude : Double = 0
    @objc dynamic var longitude : Double = 0
    @objc dynamic var time : Date?
    
    func initialize(weather : Weather) {
        self.time = Date()
        //temperature initialization
        if weather.main != nil {
            if Int(weather.main!.temp_min - 273.3) != Int(weather.main!.temp_max - 273.3) {
                self.temperature = "\(Int(weather.main!.temp_min - 273.3))...\(Int(weather.main!.temp_max - 273.3))°C"
            } else {
                self.temperature = "\(Int(weather.main!.temp_min - 273.3))°C"
            }
        }
        //info initialization
        if weather.weather != nil {
            self.info = weather.weather![0].description
        }
        //place initialization
        var plc = ""
        if let city = weather.name {
            plc += city
            if let country = weather.sys?.country {
                plc += ", \(country)"
            }
            self.place = plc
        }
        //locations initialization
        if let coordinates = weather.coord {
            self.latitude = coordinates.lat
            self.longitude = coordinates.lon
        }
    }
    
}
