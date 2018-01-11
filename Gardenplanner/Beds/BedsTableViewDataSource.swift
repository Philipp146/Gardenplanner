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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        //let entry = data
        let cell = tableView.dequeueReusableCell(withIdentifier: "BedsCell") as! BedsTableViewCell
        return cell
    }
    
    

}