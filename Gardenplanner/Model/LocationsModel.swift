//
//  LocationsModel.swift
//  Gardenplanner
//
//  Created by Philipp on 12.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class LocationsModel: NSObject {
    
    fileprivate var model = ModelSingleton.sharedInstance
    
    func numberOfEntries() -> Int{
        return model.locations.count
    }
    
    func add(location : LocationsStruct){
        model.locations.append(location)
    }
    
    func set(locations : [LocationsStruct]){
        model.locations = locations
    }
    
    func getElement(at position : Int) -> LocationsStruct{
        return model.locations[position]
    }
    
    func remove(at position : Int){
        model.locations.remove(at: position)
    }
    
    func clear(){
        model.locations = []
    }

}
