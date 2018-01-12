//
//  FetchData.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class FetchData : NSObject, NetworkSupervisor{
        
        var notificationStr = ""
        var network = Network()
        
        func fetchData(forName : String, notify : String) -> Void
        {
//            var baseURL = createBaseUrl()
//
//            let cityName = URLQueryItem(name: "q", value: forName)
//            var newQueryItems = baseURL.queryItems
//            newQueryItems?.append(cityName)
//
//            baseURL.queryItems = newQueryItems
//
//            let url = baseURL.url!
//            print(url.absoluteString)
//
//            notificationStr = notify
//            network.getData(from: url.absoluteString, supervisor: self)
        }
        
        
        func fetchData(forID : Int, notify : String) -> Void
        {
//            var baseURL = createBaseUrl()
//
//            let
//
//            let cityID = URLQueryItem(name: "id", value: String(forID))
//            var newQueryItems = baseURL.queryItems
//            newQueryItems?.append(cityID)
//
//            baseURL.queryItems = newQueryItems
//
//            let url = baseURL.url!
//
//            notificationStr = notify
//            network.getData(from: url, supervisor: self)
        }
    
    fileprivate func createBaseUrl() -> String
    {
        let urlString = "192.168.185.50:8080/Gartenplaner"
        return urlString
            
    }
    
    fileprivate func addQuery(_ query : String, _ url : String) -> String{
        return url + "/" + query
    }
        
        
    func handleReceivedData(_ d:AnyObject) -> Void
    {
//        let nc = NotificationCenter.default
//        let m = WeatherData()
//
//        guard let json = try? JSONSerialization.jsonObject(with: d as! Data, options: []) as? [String : Any] else {return}
//
//        let newEntry = WeatherEntry(withJsonForName : json!)!
//        if (m.numberOfEntries() == 0)
//        {
//            m.append(element: newEntry)
//        }
//        else {
//            m.set(element: newEntry, at: 0)
//        }
//        nc.post(name: NSNotification.Name(notificationStr), object: nil)
    }
        
    func cancel() -> Void
    {
        network.cancel()
    }

}
