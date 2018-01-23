//
//  BedsStruct.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class BedsStruct{

    var id : Int
    var owner : String
    var name : String
    var location : LocationsStruct
    var crops: [CropsStruct]
    
    func setCrops(vCrops : [CropsStruct]){
        crops = vCrops
    }

    init?(withJsonForName: [String : Any]) {
        guard let id = withJsonForName["id"] as? Int,
            let name = withJsonForName["name"] as? String,
            let locationJsonString = withJsonForName["location"] as? [String : Any],
            let crops = withJsonForName["crops"] as? [[String: Any]]
        else {
            return nil
        }
        
        self.id = id
        self.owner = "" //Muss noch ausgelesen werden
        self.name = name
        self.location = LocationsStruct(withJsonForName: locationJsonString)!
        var cropsArray : [CropsStruct] = []
        for i in crops{
            cropsArray.append(CropsStruct(withJsonForName: i, bedId : self.id)!)
        }
        self.crops = cropsArray
    }
    
    init(name : String, location : LocationsStruct) {
        id = 0
        owner = ""
        self.name = name
        self.location = location
        self.crops = []
    }
    
    func createJSONObject(bed : BedsStruct) -> [String : Any]{
        var jsonString : [String : Any] = [:]
        jsonString.updateValue(bed.name, forKey: "name")
        jsonString.updateValue(bed.location.createJSONObject(location: location), forKey: "location")
        return jsonString
    }
    
    func addCrop(crop:CropsStruct){
        self.crops.append(crop)
    }
}
