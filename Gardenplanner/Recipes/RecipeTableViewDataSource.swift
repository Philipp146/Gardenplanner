//
//  RecipeTableViewDataSource.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class RecipeTableViewDataSource: NSObject, UITableViewDataSource {
    
    var data : RecipesModel
    
    override init() {
        data = RecipesModel()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.numberOfEntries()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        var entry = data.getElement(at: index)
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell") as! RecipesTableViewCell
        return cell
    }
    

}
