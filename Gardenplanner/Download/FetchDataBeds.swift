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
    let urlBuilder = UrlBuilder()
    
    func fetchAllBeds(for user: String, notify : String){
        let url = createUrl(for: user)
        notificationStr = notify
        network.getData(from: url, supervisor: self)
    }
    
    func deleteBed(for user: String, notify : String, bed bedId : Int){
        var url = createUrl(for: user)
        url = urlBuilder.addPath("\(bedId, url)",url)
        notificationStr = notify
        network.deleteData(from: url, supervisor: self)
    }
    
    fileprivate func createUrl(for user : String) -> String{
        var url = urlBuilder.createBaseUrl()
        url = urlBuilder.addPath("user", url)
        url = urlBuilder.addPath(user.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!, url)
        url = urlBuilder.addPath("beds", url)
        return url
    }
        
    func handleReceivedData(_ d:AnyObject) -> Void
    {
        let nc = NotificationCenter.default
        let beds = BedsModel()
        
        guard let data = d as? Data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]]
            else {return}
        
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
