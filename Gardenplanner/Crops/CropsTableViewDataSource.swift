//
//  PlantsTableViewDataSource.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class CropsTableViewDataSource: NSObject, UITableViewDataSource {
    
    var data : CropsModel
    
    override init() {
        data = CropsModel()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let entry = data.getElement(at: index)
        let cell = tableView.dequeueReusableCell(withIdentifier: "CropsCell") as! CropsTableViewCell
        return cell
    }
    

}
