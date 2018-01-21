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
    var delegate : CropsTableViewDelegate!
    var data : BedsModel!
    var crops : [CropsStruct]!
    var bedsRow : Int!
    var isPutRequest = false
    var idForPutRequest = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = CropsTableViewDataSource()
        tableView.dataSource = dataSource
        delegate = CropsTableViewDelegate()
        delegate.bedRow = self.bedsRow
        delegate.vc = self
        tableView.delegate = delegate
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
        if segue.identifier == "Segue2AddCrop"{
            let addCropVC = segue.destination as! AddCropViewController
            addCropVC.bedId = data.getElement(at: bedsRow).id
            if isPutRequest{
                addCropVC.isPutRequest = true
                addCropVC.idForPutRequest = idForPutRequest
            }else{
                addCropVC.isPutRequest = false
            }
            
            
        }
        
    }

}

protocol DelegateCrop {
    //func backFromCrop(_ otherVC : CropViewController, _ showAgain : Bool)
}
