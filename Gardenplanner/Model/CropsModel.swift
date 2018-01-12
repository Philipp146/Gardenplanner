//
//  CropsModel.swift
//  Gardenplanner
//
//  Created by Philipp on 12.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class CropsModel: NSObject {
    
    fileprivate var model = ModelSingleton.sharedInstance
    
    func numberOfEntries() -> Int{
        return model.crops.count
    }
    
    func add(crop : CropsStruct){
        model.crops.append(crop)
    }
    
    func set(crops : [CropsStruct]){
        model.crops = crops
    }
    
    func getElement(at position : Int) -> CropsStruct{
        return model.crops[position]
    }
    
    func remove(at position : Int){
        model.crops.remove(at: position)
    }
    
    func clear(){
        model.crops = []
    }

}
