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
        let crop = entry.crops[index]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm"
        let date = formatter.date(from: crop.lastPoured)
        print("Last Poured: \(crop.lastPoured)")
        print("Date: \(date)")
        if let date=date{
            let wateringDate = date.addingTimeInterval(Double(crop.waterInterval)!*24*60*60)
            print("Watering Date: \(wateringDate)")
            print("Date: \(Date())")
            if Date() > wateringDate{
                cell.widthConstraint.constant = 44
            }else{
                cell.widthConstraint.constant = 0
            }
        }else{
            print("Will be hidden")
            cell.widthConstraint.constant = 0
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    

}
