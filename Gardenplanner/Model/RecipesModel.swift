//
//  RecipesModel.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class RecipesModel: NSObject {
    
    fileprivate var model = RecipesModelSingleton.sharedInstance

}

fileprivate class RecipesModelSingleton {
    fileprivate var data : [RecipesStruct] = []
    static let sharedInstance = RecipesModelSingleton()
}
