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
    let notifyString = "CropsLoaded"
    var bedsRow : Int!
    var isPutRequest = false
    var idForPutRequest = 0
    var nc : NotificationCenter!
    
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
        dataSource.bedsRow = self.bedsRow
        
        let refreshCtrl = UIRefreshControl()
        refreshCtrl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshCtrl
        
        nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(handleNotification), name: NSNotification.Name(notifyString), object: nil)

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
            cropVC.crop = data.getElement(at: bedsRow).crops[row]
        }
        if segue.identifier == "Segue2AddCrop"{
            let addCropVC = segue.destination as! AddCropViewController
            addCropVC.bedId = data.getElement(at: bedsRow).id
            if isPutRequest{
                let crop = data.getCropById(forBed: data.getElement(at: bedsRow).id, for: idForPutRequest)
                addCropVC.name = (crop?.name)!
                addCropVC.descriptionText = (crop?.description)!
                addCropVC.sowDate = (crop?.sowDate)!
                addCropVC.maturingTime = (crop?.maturingTime)!
                addCropVC.lastPoured = (crop?.lastPoured)!
                addCropVC.waterInterval = (crop?.waterInterval)!
                addCropVC.isPutRequest = true
                addCropVC.idForPutRequest = idForPutRequest
                isPutRequest = false
            }else{
                addCropVC.name = ""
                addCropVC.descriptionText = ""
                addCropVC.sowDate = ""
                addCropVC.maturingTime = ""
                addCropVC.lastPoured = ""
                addCropVC.waterInterval = ""
                addCropVC.isPutRequest = false
            }
        }
    }
    
    
    @objc func handleNotification(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func handleRefresh(){
        DispatchQueue.main.async {
            let fetch = FetchDataCrops()
            fetch.fetchAllCrops(for: Constants.userEmail, notify: self.notifyString, bed: self.data.getElement(at: self.bedsRow).id)
            self.tableView.reloadData()
            self.tableView.refreshControl!.endRefreshing()
        }
        
    }

}

protocol DelegateCrop {
    //func backFromCrop(_ otherVC : CropViewController, _ showAgain : Bool)
}

protocol PostRequestCallback{
    func notifyPostDone()
}
