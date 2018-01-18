//
//  PlantsTableViewDataSource.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class CropsTableViewDataSource: NSObject, UITableViewDataSource {
    
    var data : BedsModel
    var bedsRow : Int!
    
    override init() {
        data = BedsModel()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.getElement(at: bedsRow).crops.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let entry = data.getElement(at: bedsRow)
        let cell = tableView.dequeueReusableCell(withIdentifier: "CropsCell") as! CropsTableViewCell
        cell.name.text = entry.crops[index].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let index = indexPath.row
            let entry = data.getElement(at: bedsRow)
            let fetch = FetchDataCrops()
            fetch.deleteCrop(for: "maxi@sonntags.net", notify: "notify", crop: entry.crops[index].id, bed: entry.id)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

}
