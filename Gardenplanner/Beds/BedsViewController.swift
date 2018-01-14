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
    let notifyString = "BedsLoaded"
    var nc : NotificationCenter!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = BedsTableViewDataSource()
        tableView.dataSource = dataSource
        let fetch = FetchDataBeds()
        fetch.fetchAllBeds(for: "maxi@sonntags.net", notify: notifyString)
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue2AddBed"{
            let addBedVC = segue.destination as! AddBedViewController
            addBedVC.delegate = self
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol DelegateAddBed{
    func backFromAddBed(_ otherVC: AddBedViewController)
}
