//
//  RecipesModel.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class RecipesModel: NSObject {
    
    fileprivate var model = ModelSingleton.sharedInstance
    
    func numberOfEntries() -> Int{
        return model.recipes.count
    }
    
    func add(recipe : RecipesStruct){
        model.recipes.append(recipe)
    }
    
    func set(recipes : [RecipesStruct]){
        model.recipes = recipes
    }
    
    func getElement(at position : Int) -> RecipesStruct{
        return model.recipes[position]
    }
    
    func remove(at position : Int){
        model.recipes.remove(at: position)
    }
    
    func clear(){
        model.recipes = []
    }

}
