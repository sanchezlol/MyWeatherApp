//
//  WeatherModel.swift
//  MyWeatherApp
//
//  Created by Alexandr on 3/5/18.
//  Copyright © 2018 Alexandr. All rights reserved.
//

import RealmSwift

class WeatherModel {
    
    static func saveItemToDataBase(object: WeatherObject) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(object)
            print("Successful saving to Realm")
        }
        
    }
    
    static func getAllItems() -> Array<WeatherObject>?{
        
        let realm = try! Realm()
        
        return(Array(realm.objects(WeatherObject.self)).reversed())
        
    }
    static func deleteAllItems() {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
            print("Successful Realm cleaning")
        }
        
    }
    
        
    
    
    
}

