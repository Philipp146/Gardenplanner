//
//  WeatherModel.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class WeatherModel: NSObject {
    
    fileprivate var model = ModelSingleton.sharedInstance
    
    func numberOfEntries() -> Int{
        return model.weathers.count
    }
    
    func add(weather : WeatherStruct){
        model.weathers.append(weather)
    }
    
    func set(weathers : [WeatherStruct]){
        model.weathers = weathers
    }
    
    func getElement(at position : Int) -> WeatherStruct{
        return model.weathers[position]
    }
    
    func remove(at position : Int){
        model.weathers.remove(at: position)
    }
    
    func clear(){
        model.weathers = []
    }

}
