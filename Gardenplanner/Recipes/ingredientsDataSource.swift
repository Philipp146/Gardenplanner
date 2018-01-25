//
//  IngredientsDataSource.swift
//  Gardenplanner
//
//  Created by Normen Krug on 25.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import Foundation
import UIKit

class IngredientsDataSource: NSObject, UITableViewDataSource{
    
    var ingredients: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngCell") as! IngredientCell
        let index = indexPath.row
        cell.IngredientLabel.text = ingredients[index]
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
