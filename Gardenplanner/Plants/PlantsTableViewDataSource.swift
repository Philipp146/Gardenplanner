//
//  PlantsTableViewDataSource.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class PlantsTableViewDataSource: NSObject, UITableViewDataSource {
    
    var data : PlantsModel
    
    override init() {
        data = PlantsModel()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        //let entry =
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlantsCell")
    }
    

}
