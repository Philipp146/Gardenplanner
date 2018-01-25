//
//  FetchIngredients.swift
//  Gardenplanner
//
//  Created by Normen Krug on 22.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import Foundation

class FetchIngredient: NSObject, NetworkSupervisor {
    
    var ingStrings: [String] = []
    var notificationStr = "detail"
    var network = Network()
    let urlBuilder = UrlBuilder()
    
    
    func getDetailForRecipe(id: String){
        let url = createUrl(for: id)
        notificationStr = "detail"
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
        
        guard let recipe = json!["recipe"] as? [String: Any],
            let ingredients = recipe["ingredients"] as? [String]
            else {
                return
        }
        for item in ingredients{
            ingStrings.append(item)
        }
        nc.post(name: NSNotification.Name(notificationStr), object: nil)
    }
    fileprivate func createUrl(for id : String) -> String{
        var url = urlBuilder.createBaseUrl()
        url = urlBuilder.addPath("recipe", url)
        url = urlBuilder.addQueryId(key: "id", value: id, url: url)
        return url
    }
    
    func handleReceivedPostData(_ d: Data) {
        //
    }
    
    func handleReceivedDataWithPos(_ d: Data, _ pos: Int) {
        //
    }
    
    func parseJSON(){
        
    }
}
