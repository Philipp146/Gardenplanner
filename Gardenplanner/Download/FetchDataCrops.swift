//
//  FetchDataCrops.swift
//  Gardenplanner
//
//  Created by Philipp on 13.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class FetchDataCrops: NSObject, NetworkSupervisor{
    
    
    let urlBuilder = UrlBuilder()
    var notificationStr = ""
    let network = Network()
    var currentBedId = 0
    var callbackReceiver : PostRequestCallback!
    
    func handleReceivedPostData(_ d: Data) {
        let nc = NotificationCenter.default
        let beds = BedsModel()
        guard let json = try? JSONSerialization.jsonObject(with: d, options: []) as? [String : Any]
            else {
                print("Data was incorrect")
                return
        }
        var crop = CropsStruct(withJsonForName: json!, bedId:currentBedId)
        
        
        beds.deleteCropById(forBed: currentBedId, forCrop: crop!.id)
        crop?.bedId = currentBedId
        beds.addCrop(forBed: currentBedId, crop: crop!)
        
        
        callbackReceiver.notifyPostDone()
            
        nc.post(name: NSNotification.Name(notificationStr), object: nil)
    }
    
    func handleReceivedData(_ d: Data) {
        let nc = NotificationCenter.default
        let beds = BedsModel()
        guard let json = try? JSONSerialization.jsonObject(with: d, options: []) as? [[String : Any]]
            else {
                print("Data was incorrect")
                return
        }
        
        if json!.count > 0{
            beds.deleteAllCrops(forBed: currentBedId)
            for i in json!{
                var crop = CropsStruct(withJsonForName: i, bedId:currentBedId)
                crop?.bedId = currentBedId
                beds.addCrop(forBed: currentBedId, crop: crop!)
            }
        }
        nc.post(name: NSNotification.Name(notificationStr), object: nil)
    }
    
    func fetchAllCrops(for user : String, notify : String, bed bedId : Int){
        currentBedId = bedId
        let url = createUrl(for: user, bed: bedId)
        notificationStr = notify
        network.getData(from: url, supervisor: self)
    }
    
    func deleteCrop(for user: String, notify : String, crop cropId : Int, bed bedId : Int){
        currentBedId = bedId
        var url = createUrl(for: user, bed: bedId)
        url = urlBuilder.addPath("\(cropId)",url)
        notificationStr = notify
        network.deleteData(from: url, supervisor: self)
    }
    
    func postCrop(for user : String, notify : String, bedId : Int, cropJsonString crop : [String : Any]){
        currentBedId = bedId
        let url = createUrl(for: user, bed: bedId)
        notificationStr = notify
        if JSONSerialization.isValidJSONObject(crop){
            network.postData(to: url, jsonObject: crop, supervisor: self)
        }
    }
    
    func putCrop(for user:String, notify : String, bedId : Int, cropId : Int, cropJsonString crop : [String : Any]){
        currentBedId = bedId
        var url = createUrl(for: user, bed: bedId)
        url = urlBuilder.addPath("\(cropId)", url)
        notificationStr = notify
        if JSONSerialization.isValidJSONObject(crop){
            network.putData(to: url, jsonObject: crop, supervisor: self)
        }
    }
   
    fileprivate func createUrl(for user : String, bed bedId : Int) -> String{
        var url = urlBuilder.createBaseUrl()
        url = urlBuilder.addPath("user", url)
        url = urlBuilder.addPath(user.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!, url)
        url = urlBuilder.addPath("beds", url)
        url = urlBuilder.addPath("\(bedId)", url)
        url = urlBuilder.addPath("crops", url)
        return url
    }

}
