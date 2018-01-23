//
//  FetchData.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class FetchDataBeds : NSObject, NetworkSupervisor{
    func handleReceivedDataWithPos(_ d: Data, _ pos: Int) {
        //unused
    }
    
        
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
        url = urlBuilder.addPath("\(bedId)",url)
        notificationStr = notify
        network.deleteData(from: url, supervisor: self)
    }
    
    func postBed(for user: String, notify : String, bedJsonString bed : [String : Any]){
        let url = createUrl(for: user)
        notificationStr = notify
        if(JSONSerialization.isValidJSONObject(bed)){
            network.postData(to: url, jsonObject: bed , supervisor: self)
        }else{
            print("BOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOM")
        }
    }
    
    func putBed(for user: String, notify : String, bed bedId : Int, bedJsonString bed : [String : Any]){
        var url = createUrl(for: user)
        url = urlBuilder.addPath("\(bedId)", url)
        notificationStr = notify
        if JSONSerialization.isValidJSONObject(bed){
            network.putData(to: url, jsonObject: bed, supervisor: self)
        }
        
    }
    
    fileprivate func createUrl(for user : String) -> String{
        var url = urlBuilder.createBaseUrl()
        url = urlBuilder.addPath("user", url)
        url = urlBuilder.addPath(user.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!, url)
        url = urlBuilder.addPath("beds", url)
        return url
    }
        
    func handleReceivedData(_ d:Data) -> Void
    {
        let nc = NotificationCenter.default
        let beds = BedsModel()
        guard let json = try? JSONSerialization.jsonObject(with: d, options: []) as? [[String : Any]]
            else {
                print("Data was incorrect")
                return
        }
        
        if json!.count > 0{
            beds.clear()
            for i in json!{
                beds.add(bed: BedsStruct(withJsonForName: i)!)
            }
        }
        nc.post(name: NSNotification.Name(notificationStr), object: nil)
    }
    
    func handleReceivedPostData(_ d: Data) {
        let nc = NotificationCenter.default
        let beds = BedsModel()
        guard let json = try? JSONSerialization.jsonObject(with: d, options: []) as? [String : Any]
            else {
                print("Data was incorrect")
                return
        }
        beds.add(bed: BedsStruct(withJsonForName: json!)!)
        nc.post(name: NSNotification.Name(notificationStr), object: nil)
    }
        
    func cancel() -> Void
    {
        network.cancel()
    }

}
