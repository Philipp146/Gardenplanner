//
//  LocationsStruct.swift
//  Gardenplanner
//
//  Created by Philipp on 12.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

struct LocationsStruct {
    
    var id : Int
    var zip : String
    var city : String
    var weather : [WeatherStruct]
    var country : String
    var indoor : Bool
    
}

extension LocationsStruct{
    init?(withJsonForName: [String : Any]) {
        guard let id = withJsonForName["id"] as? Int,
            let zip = withJsonForName["postalCode"] as? String,
            let city = withJsonForName["city"] as? String,
            let weather = withJsonForName["weather"] as? [[String : Any]],
            let country = withJsonForName["country"] as? String,
            let indoor = withJsonForName["indoor"] as? Bool
            else {
                return nil
        }
        
        self.id = id
        self.zip = zip //Muss noch ausgelesen werden
        self.city = city
        var weatherArray : [WeatherStruct] = []
        for i in weather{
            weatherArray.append(WeatherStruct(withJsonForName: i)!)
        }
        self.weather = weatherArray
        self.country = country
        self.indoor = indoor
        
    }
    
    init(zip : String, city : String, country : String, indoor : Bool) {
        self.id = 0
        self.zip = zip
        self.city = city
        self.country = country
        self.indoor = indoor
        self.weather = []
    }
    
    func createJSONObject(location location : LocationsStruct) -> [String : Any]{
        var jsonString : [String : Any] = [:]
        jsonString.updateValue(location.id, forKey: "id")
        jsonString.updateValue(location.zip, forKey: "postalCode")
        jsonString.updateValue(location.city, forKey: "city")
        jsonString.updateValue(location.weather, forKey: "weather")
        jsonString.updateValue(location.country, forKey: "country")
        jsonString.updateValue(location.indoor, forKey: "indoor")
        return jsonString
    }
}
