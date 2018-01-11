//
//  Network.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import Foundation

class Network{
    
    var task : URLSessionDataTask!
    
    func getData(from urlString : String, supervisor : NetworkSupervisor) -> Void
    {
        let url = URL(string: urlString)!
        
        let session = URLSession.shared
        let task = session.dataTask(with: url){
            data, response, error in
            
            // Daten "atomar übergeben"
            supervisor.handleReceivedData(data as AnyObject)
        }
        task.resume()
        
    }
    
    func cancel () -> Void
    {
        task.cancel()
    }
}
