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
    var data = UserModel()
    
    func getData(from urlString : String, supervisor : NetworkSupervisor) -> Void
    {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod="GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Test123", forHTTPHeaderField: "token")
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            supervisor.handleReceivedData(data as AnyObject)
        }
        task.resume()
        
    }
    
    
    
    func cancel () -> Void
    {
        task.cancel()
    }
}
