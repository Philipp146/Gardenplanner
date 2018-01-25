//
//  SearchBarDelegate.swift
//  Gardenplanner
//
//  Created by Normen Krug on 21.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import Foundation
import UIKit

class SearchBarDelegate: NSObject, UISearchBarDelegate{
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name("searchBar"), object: nil)
        searchBar.resignFirstResponder()
    }
    
}
