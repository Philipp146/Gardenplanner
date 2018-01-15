//
//  FetchData.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class FetchDataBeds : NSObject, NetworkSupervisor{
        
    var notificationStr = ""
    var network = Network()
    
    func fetchAllBeds(for user: String, notify : String){
        let urlBuilder = UrlBuilder()
        var url = urlBuilder.createBaseUrl()
        url = urlBuilder.addPath("user", url)
        url = urlBuilder.addPath(user.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!, url)
        url = urlBuilder.addPath("beds", url)
        notificationStr = notify
        network.getData(from: url, supervisor: self)
    }
        
    func handleReceivedData(_ d:AnyObject) -> Void
    {
        let nc = NotificationCenter.default
        let beds = BedsModel()
        
        guard let json = try?
            JSONSerialization.jsonObject(with: d as! Data, options: []) as? [[String : Any]] else {return}
        
        if json!.count > 0{
            beds.clear()
            for i in json!{
                beds.add(bed: BedsStruct(withJsonForName: i)!)
            }
        }
        nc.post(name: NSNotification.Name(notificationStr), object: nil)
    }
        
    func cancel() -> Void
    {
        network.cancel()
    }

}
