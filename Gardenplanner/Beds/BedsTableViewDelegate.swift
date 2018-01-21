//
//  BedsTableViewDelegate.swift
//  Gardenplanner
//
//  Created by Philipp on 18.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class BedsTableViewDelegate: NSObject, UITableViewDelegate {
    
    fileprivate let data : BedsModel!
    var vc : BedsViewController!
    
    override init() {
        data = BedsModel()
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let index = indexPath.row
        let entry = data.getElement(at: index)
        let editAction = UITableViewRowAction(style: .normal, title: "Edit"){(action,indexPath) -> Void in
            self.vc.bedIndexForPut = index
            self.vc.openWithPut = true
            self.vc.performSegue(withIdentifier: "Segue2AddBed", sender: nil)
        }
        editAction.backgroundColor = UIColor.orange
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete"){(action,indexPath) -> Void in
            let fetchDataBeds = FetchDataBeds()
            fetchDataBeds.deleteBed(for: "maxi@sonntags.net", notify: "notify", bed: entry.id)
            self.data.remove(at: index)
            tableView.reloadData()
        }
        deleteAction.backgroundColor = UIColor.red
        return [editAction,deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.insert
    }
    
    
}
