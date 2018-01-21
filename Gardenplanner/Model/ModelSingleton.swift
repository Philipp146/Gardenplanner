//
//  ModelSingleton.swift
//  Gardenplanner
//
//  Created by Philipp on 12.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class ModelSingleton {
    var beds : [BedsStruct] = []
    var users : [UsersStruct] = []
    var locations : [LocationsStruct] = []
    var crops : [CropsStruct] = []
    var recipes : [RecipesStruct] = []
    var weathers : [WeatherStruct] = []
    static let sharedInstance = ModelSingleton()
    
    func getLocationById(for id : Int) -> LocationsStruct?{
        for i in locations{
            if id == i.id{
                 return i
            }
        }
        return nil
    }
    
    func getUserByMail(for mail : String) -> UsersStruct?{
        for i in users{
            if mail == i.email{
                return i
            }
        }
        return nil
    }
    
    func getBedById(for id : Int) -> BedsStruct?{
        dump(beds)
        for i in beds{
            if id == i.id{
                return i
            }
        }
        return nil
    }
    
}
