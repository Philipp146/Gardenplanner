//
//  FetchDataRecipe.swift
//  Gardenplanner
//
//  Created by Normen Krug on 21.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import Foundation

class FetchDataRecipe: NSObject, NetworkSupervisor{
    func handleReceivedDataWithPos(_ d: Data, _ pos: Int) {
        //unused
    }
    
    
    var notificationStr = ""
    var network = Network()
    let urlBuilder = UrlBuilder()
    
    func getRecipes(name: String){
        let url = createUrl(for: name)
        notificationStr = "recipesList"
        network.getData(from: url, supervisor: self)
    }
    
    
    func handleReceivedData(_ d: Data) {
        let nc = NotificationCenter.default
        let recipes = RecipesModel()
        guard let json = try? JSONSerialization.jsonObject(with: d, options: []) as? [String : Any]
            else {
                print("Data was incorrect")
                return
        }
        recipes.clear()
        
        let jsonList = json!["recipeList"] as! [[String: Any]]
        for i in jsonList{
            recipes.add(recipe: RecipesStruct(withJsonForName: i)!)
            
        }
        nc.post(name: NSNotification.Name(notificationStr), object: nil)
        }
    

    
    func handleReceivedPostData(_ d: Data) {
        //unused
    }
  
    fileprivate func createUrl(for recipes : String) -> String{
        var url = urlBuilder.createBaseUrl()
        url = urlBuilder.addPath("recipes", url)
        url = urlBuilder.addQuery(key: "q", value: recipes, url: url)
        return url
    }
    
}

