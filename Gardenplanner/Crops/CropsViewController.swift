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
    var data : BedsModel!
    var crops : [CropsStruct]!
    var bedsRow : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = CropsTableViewDataSource()
        tableView.dataSource = dataSource
        data = BedsModel()
        print(bedsRow)
        crops = data.getElement(at: bedsRow).crops
        dataSource.bedsRow = self.bedsRow

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Segue2Crop"{
            let cropVC = segue.destination as! CropViewController
            let row = tableView.indexPathForSelectedRow!.row
            cropVC.delegate = self
            cropVC.crop = crops[row]
        }
        
    }

}

protocol DelegateCrop {
    //func backFromCrop(_ otherVC : CropViewController, _ showAgain : Bool)
}
