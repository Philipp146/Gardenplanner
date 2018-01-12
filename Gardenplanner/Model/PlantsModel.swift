//
//  PlantsModel.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class CropsModel: NSObject {
    
    fileprivate var model = ModelSingleton.sharedInstance
    
    func numberOfEntries() -> Int{
        return model.plants.count
    }
    
    func add(_ plant : CropsStruct){
        model.plants.append(plant)
    }
    
    func set(_ plants : [CropsStruct]){
        model.plants = plants
    }
    
    func getElement(at position : Int) -> CropsStruct{
        return model.plants[position]
    }
    
    func remove(at position : Int){
        model.plants.remove(at: position)
    }
    
    func clear(){
        model.plants = []
    }

}
