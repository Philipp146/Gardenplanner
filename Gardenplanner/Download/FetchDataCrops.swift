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
    
    func handleReceivedData(_ d: AnyObject) {
        
    }
    
    func deleteCrop(for user: String, notify : String, crop cropId : Int, bed bedId : Int){
        var url = createUrl(for: user, bed: bedId)
        url = urlBuilder.addPath("\(cropId)",url)
        notificationStr = notify
        network.deleteData(from: url, supervisor: self)
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
