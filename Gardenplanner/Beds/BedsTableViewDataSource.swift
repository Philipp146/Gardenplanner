//
//  BedsTableViewDataSource.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class BedsTableViewDataSource: NSObject, UITableViewDataSource {
    
    fileprivate let data : BedsModel!
    
    override init() {
        data = BedsModel()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.numberOfEntries()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let entry = data.getElement(at: index)
        let cell = tableView.dequeueReusableCell(withIdentifier: "BedsCell") as! BedsTableViewCell
        cell.name.text = entry.name
        cell.location.text = entry.location.country
        print(cell.location.text!)
        return cell
    }
    
    

}
