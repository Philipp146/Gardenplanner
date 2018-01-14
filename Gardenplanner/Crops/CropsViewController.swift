//
//  PlantsViewController.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class CropsViewController: UIViewController, DelegateCrop {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource : CropsTableViewDataSource!
    var data : CropsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = CropsTableViewDataSource()
        tableView.dataSource = dataSource
        
        data = CropsModel()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = tableView.indexPathForSelectedRow!.row
        if segue.identifier == "Segue2Crop"{
            let cropVC = segue.destination as! CropViewController
            cropVC.delegate = self
            cropVC.crop = data.getElement(at: row)
        }
        
    }

}

protocol DelegateCrop {
    //func backFromCrop(_ otherVC : CropViewController, _ showAgain : Bool)
}
