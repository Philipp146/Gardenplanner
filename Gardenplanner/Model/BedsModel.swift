//
//  BedsModel.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class BedsModel: NSObject {
    
    fileprivate var model = ModelSingleton.sharedInstance
    
    func numberOfEntries() -> Int{
        return model.beds.count
    }
    
    func add(bed : BedsStruct){
        model.beds.append(bed)
    }
    
    func set(beds : [BedsStruct]){
        model.beds = beds
    }
    
    func getElement(at position : Int) -> BedsStruct{
        return model.beds[position]
    }
    
    func remove(at position : Int){
        model.beds.remove(at: position)
    }
    
    func clear(){
        model.beds = []
    }
    
    func getLocationName(for id : Int) -> String{
        if let location = model.getLocationById(for: id){
            return location.zip + ", " + location.country
        }
        return "No Location set"
    }
}
