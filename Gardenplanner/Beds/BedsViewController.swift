//
//  BedsViewController.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class BedsViewController: UIViewController, DelegateAddBed{


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    
    var searchController : UISearchController!
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
        dataSource.viewController = self
        tableView.dataSource = dataSource
        delegate = BedsTableViewDelegate()
        delegate.vc = self
        tableView.delegate = delegate
        searchController = UISearchController(searchResultsController: self)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40))
        
        let fetch = FetchDataBeds()
        fetch.fetchAllBeds(for: Constants.userEmail, notify: notifyString)
        let refreshCtrl = UIRefreshControl()
        refreshCtrl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshCtrl
        
        searchController.searchResultsUpdater = dataSource as UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        
        
        searchController.searchBar.placeholder = "Search Beds"
        if #available(iOS 11.0, *) {
            print("set search controller")
            self.navigationItem.searchController = searchController
        } else {
            tableView.tableHeaderView = searchController.searchBar
            
        }
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
        nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(handleNotification), name: NSNotification.Name(notifyString), object: nil)
        
        let leftItem = UIBarButtonItem(title: "Ausloggen", style: .done, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = leftItem
        // Do any additional setup after loading the view.
    }
   
    @objc func goBack(){
        print("Go back called")
        performSegue(withIdentifier: "UnwindToLogin", sender: self)
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
            BedsModel().clear()
            let fetch = FetchDataBeds()
            fetch.fetchAllBeds(for: Constants.userEmail, notify: self.notifyString)
            self.tableView.reloadData()
            self.tableView.refreshControl!.endRefreshing()
        }
        
    }
    
    @objc func toWeather(sender:AnyObject){
        var button = sender as! UIButton
        var row = button.tag
        DispatchQueue.main.async(execute: {
             self.performSegue(withIdentifier: "Beds2Weather", sender: row)
        })
       
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
                openWithPut = false
            }else{
                addBedVC.name = ""
                addBedVC.city = ""
                addBedVC.country = ""
                addBedVC.zip = ""
                addBedVC.indoorSegment = 0
                addBedVC.isPutRequest = false
            }
        }
        if segue.identifier == "Segue2Crops"{
            let cropsVC = segue.destination as! CropsViewController
            let row = tableView.indexPathForSelectedRow!.row
            print("Beds: \(row)")
            cropsVC.bedsRow = row
        }
        
        if segue.identifier == "Beds2Weather" {
            let weatherVC = segue.destination as! WeatherGraphViewController
            let row = sender as! Int
            let bed = BedsModel().getElement(at: row)
            weatherVC.bed = bed
            
        }
    }

    @IBAction func add(_ sender: Any) {
        openWithPut = false
    }
}

protocol DelegateAddBed{
    func backFromAddBed(_ otherVC: AddBedViewController)
}




