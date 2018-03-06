//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Alexandr on 3/5/18.
//  Copyright © 2018 Alexandr. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var latitude : Double? = nil
    var longitude : Double? = nil
    
    var currentWeather : WeatherObject? = nil
    
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.updateLocation()
            while self.latitude == nil && self.longitude == nil {
                usleep(100000)
                self.updateLocation()
            }
            self.updateWeatherWithCurrentLocation()
        }
        
        
    }

    func updateWeatherWithCurrentLocation(){
        
        if latitude != nil && longitude != nil {
            
            if let url = generateUrl(latitude: latitude!, longitude: longitude!){
                
                let currentTask = URLSession.shared.dataTask(with: url) {
                    
                    (data, response, error) in
                    
                    guard let data = data else { return }
                    
                    do {
                        
                        let content = try JSONDecoder().decode(Weather.self, from: data)
                        
                        let obj = WeatherObject()
                        obj.initialize(weather: content)
                        DispatchQueue.global(qos: .background).async {
                            WeatherModel.saveItemToDataBase(object: obj)
                        }
                        self.currentWeather = obj
                        DispatchQueue.main.sync {
                            self.updateUI()
                        }
                        
                    } catch {
                        print(error)
                    }
                }
                
                currentTask.resume()
            } else {
                print("Invalid url")
            }
        }
    }
    private func updateUI(){
        
            self.placeLabel.text = "\(currentWeather!.place)"
            self.placeLabel.isHidden = false
            self.temperatureLabel.text = "\(currentWeather!.temperature)"
            self.temperatureLabel.isHidden = false
            self.infoLabel.text = "\(currentWeather!.info)"
            self.infoLabel.isHidden = false
            self.icon.image = IconChooser.chooseIcon(forDescription: currentWeather!.info)
    }
    
    private func updateLocation(){
        guard let locValue : CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
        self.latitude = locValue.latitude
        self.longitude = locValue.longitude
        DispatchQueue.main.async {
            self.coordinatesLabel.text = "\(locValue.latitude) \(locValue.longitude)"
            self.coordinatesLabel.isHidden = false
        }
        print("locations: \(locValue.latitude) \(locValue.longitude)")
    }

    private func generateUrl(latitude lat: Double, longitude lon: Double) -> URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/weather"
        
        let queryItem1 = URLQueryItem(name: "lat", value: "\(lat)")
        let queryItem2 = URLQueryItem(name: "lon", value: "\(lon)")
        let queryItem3 = URLQueryItem(name: "appid", value: "1813bf166bb7378f9a051c8f9a12009e")
        
        components.queryItems = [queryItem1, queryItem2, queryItem3]
        
        if let url : URL = components.url {
//            print("Query url: " + String(describing: components.url!))
            return url
        } else {
            return nil
        }
    }
    
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        updateLocation()
        updateWeatherWithCurrentLocation()
    }
    
}

