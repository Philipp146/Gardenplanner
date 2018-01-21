//
//  CropsTableViewDelegate.swift
//  Gardenplanner
//
//  Created by Philipp on 20.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class CropsTableViewDelegate: NSObject, UITableViewDelegate {

    fileprivate let data : BedsModel!
    var vc : CropsViewController!
    var bedRow = 0
    
    override init() {
        data = BedsModel()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let index = indexPath.row
        let entry = data.getElement(at: bedRow).crops[index]
        let editAction = UITableViewRowAction(style: .normal, title: "Edit"){(action,indexPath) -> Void in
            self.vc.idForPutRequest = entry.id
            self.vc.isPutRequest = true
            self.vc.performSegue(withIdentifier: "Segue2AddCrop", sender: nil)
        }
        editAction.backgroundColor = UIColor.orange
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete"){(action,indexPath) -> Void in
            let fetchDataCrops = FetchDataCrops()
            fetchDataCrops.deleteCrop(for: "maxi@sonntags.net", notify: "CropsLoaded", crop: entry.id, bed: entry.bedId)
            let bedId = self.data.getElement(at: self.bedRow).id
            self.data.deleteCrop(forBed: bedId, atIdx: indexPath.row)
            tableView.reloadData()
        }
        deleteAction.backgroundColor = UIColor.red
        return [editAction,deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.insert
    }
}
