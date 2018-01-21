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
    
    func getLocationName(for locationId : Int) -> String{
        if let location = model.getLocationById(for: locationId){
            return location.zip + ", " + location.country
        }
        return "No location set"
    }
    
    func getBedNameById(for id : Int) -> String{
        if let bed = model.getBedById(for: id){
            return bed.name
        }
        return "No name set"
    }
    
    func getCropById(forBed bedId : Int,for id: Int) -> CropsStruct?{
        if let bed = model.getBedById(for: bedId){
            for i in bed.crops{
                if i.id == id{
                    return i
                }
            }
        }
        
        return nil
    }
    
    func addCrop(forBed bedId:Int, crop:CropsStruct){
        model.getBedById(for: bedId)?.addCrop(crop: crop)
    }
    
    func deleteCrop(forBed bedId:Int, atIdx:Int){
        model.getBedById(for: bedId)?.crops.remove(at: atIdx)
    }
    
    func deleteAllCrops(forBed bedId : Int){
        model.getBedById(for: bedId)?.crops.removeAll()
    }
    
    func deleteCropById(forBed bedId:Int, forCrop cropId:Int){
        for i in 0..<(model.getBedById(for: bedId)?.crops)!.count{
            if model.getBedById(for: bedId)?.crops[i].id == cropId{
                model.getBedById(for: bedId)?.crops.remove(at: i)
                break
            }
        }
    }
    func deleteBedById(id bedId:Int){
        for i in 0 ..< model.beds.count {
            if model.beds[i].id == bedId{
                model.beds.remove(at: i)
                break
            }
        }
    }
}
