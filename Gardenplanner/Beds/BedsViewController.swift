//
//  BedsViewController.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class BedsViewController: UIViewController, DelegateAddBed{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource : BedsTableViewDataSource!
    var delegate : BedsTableViewDelegate!
    let notifyString = "BedsLoaded"
    var nc : NotificationCenter!
    var openWithPut = false
    var bedIndexForPut = 0
    var data : BedsModel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = BedsModel()
        dataSource = BedsTableViewDataSource()
        tableView.dataSource = dataSource
        delegate = BedsTableViewDelegate()
        delegate.vc = self
        tableView.delegate = delegate
        let fetch = FetchDataBeds()
        fetch.fetchAllBeds(for: "maxi@sonntags.net", notify: notifyString)
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
    
    func backFromAddBed(_ otherVC: AddBedViewController) {
        otherVC.dismiss(animated: true)
    }
    
    @objc func handleNotification(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func handleRefresh(){
        DispatchQueue.main.async {
            let fetch = FetchDataBeds()
            fetch.fetchAllBeds(for: "maxi@sonntags.net", notify: self.notifyString)
            self.tableView.reloadData()
            self.tableView.refreshControl!.endRefreshing()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue2AddBed"{
            let addBedVC = segue.destination as! AddBedViewController
            addBedVC.delegate = self
            if openWithPut{
                let bed = data.getElement(at: bedIndexForPut)
                addBedVC.name = bed.name
                addBedVC.city = bed.location.city
                addBedVC.country = bed.location.country
                addBedVC.zip = bed.location.zip
                if bed.location.indoor{
                    addBedVC.indoorSegment = 1
                }else{
                    addBedVC.indoorSegment = 0
                }
                addBedVC.isPutRequest = true
                addBedVC.idForPutRequest = bed.id
            }
        }
        if segue.identifier == "Segue2Crops"{
            let cropsVC = segue.destination as! CropsViewController
            let row = tableView.indexPathForSelectedRow!.row
            print("Beds: \(row)")
            cropsVC.bedsRow = row
        }
    }

    @IBAction func add(_ sender: Any) {
        openWithPut = false
    }
}

protocol DelegateAddBed{
    func backFromAddBed(_ otherVC: AddBedViewController)
}
