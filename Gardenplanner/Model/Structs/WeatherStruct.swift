//
//  WeatherStruct.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

struct WeatherStruct{
    
    var id : Int
    var date : String
    var rainfall : Int
    var sunHours : Double
    var temperature : Double
    var locationId : Int
}

extension WeatherStruct{
    init?(withJsonForName: [String : Any]) {
        guard let id = withJsonForName["id"] as? Int,
            let date = withJsonForName["date"] as? String,
            let rainfall = withJsonForName["rainfall"] as? Int,
            let sunHours = withJsonForName["sun_hours"] as? Double,
            let temperature = withJsonForName["temperature"] as? Double
            else{
                return nil
        }
        
        self.id = id
        self.date = date
        self.rainfall = rainfall
        self.sunHours = sunHours
        self.temperature = temperature
        self.locationId = 0 //Muss noch eingefügt werden
    }
}
