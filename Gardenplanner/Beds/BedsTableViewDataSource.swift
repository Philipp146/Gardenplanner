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
    var viewController : BedsViewController!
    var filteredBeds : BedsModel!
    
    override init() {
        data = BedsModel()
        filteredBeds = BedsModel()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering(){
            return filteredBeds.getBeds().count
        }
        return data.numberOfEntries()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let entry : BedsStruct  //data.getElement(at: index)
        if isFiltering(){
            entry = filteredBeds.getBeds()[index]
        }else{
            entry = data.getElement(at: index)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "BedsCell") as! BedsTableViewCell
        cell.name.text = entry.name
        cell.location.text = "\(entry.location.zip), \(entry.location.city), \(entry.location.country)"
        print(cell.location.text!)
        
        
        cell.weatherButton.tag = indexPath.row
        cell.weatherButton.addTarget(self, action: #selector(toWeather(sender:)), for: .touchUpInside)
        
        
        return cell
    }
    
    @objc func toWeather(sender: UIButton!){
        viewController.toWeather(sender: sender)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func isFiltering() -> Bool {
        return viewController.searchController.isActive && !searchBarIsEmpty()
    }
    
    
    

}

extension BedsTableViewDataSource : UISearchResultsUpdating {
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return viewController.searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        let filtered = data.getBeds().filter({( bed : BedsStruct) -> Bool in
            return bed.name.lowercased().contains(searchText.lowercased())
        })
        filteredBeds.set(beds: filtered)
        
        viewController.tableView.reloadData()
    }
}
