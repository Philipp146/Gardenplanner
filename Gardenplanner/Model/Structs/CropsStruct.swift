//
//  PlantsStruct.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

struct CropsStruct {
    
    var id : Int
    var bedId : Int
    var name : String
    var description : String
    var sowDate : String
    var waterInterval : String
    var lastPoured : String
    var maturingTime : String

}

extension CropsStruct {
    init?(withJsonForName: [String : Any]) {
        guard let id = withJsonForName["id"] as? Int,
            let name = withJsonForName["name"] as? String,
            let description = withJsonForName["description"] as? String,
            let sowDate = withJsonForName["sowDate"] as? String,
            let waterInterval = withJsonForName["waterInterval"] as? String,
            let lastPoured = withJsonForName["lastPoured"] as? String,
            let maturingTime = withJsonForName["maturingTime"] as? String
        else {
            return nil
        }
        self.id = id
        self.bedId = 0 //Muss noch ausgelesen werden
        self.name = name
        self.description = description
        self.sowDate = sowDate
        self.waterInterval = waterInterval
        self.lastPoured = lastPoured
        self.maturingTime = maturingTime
    }
}

