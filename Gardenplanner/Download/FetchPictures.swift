//
//  FetchPictures.swift
//  Gardenplanner
//
//  Created by Normen Krug on 21.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import Foundation
import UIKit

class FetchPictures: NSObject, NetworkSupervisor{
    
    func handleReceivedData(_ d: Data) {
       // unused
    }
    var notificationStr = "pictures"
    var network = Network()
    
    func handleReceivedDataWithPos(_ d: Data, _ pos: Int) {
        let nc = NotificationCenter.default
        if let image = UIImage(data: d){
            ModelSingleton.sharedInstance.recipes[pos].pictures = image
           
        }
        else{
            return
        }
        
        nc.post(name: NSNotification.Name(notificationStr), object: nil)
        
        
    }
    
    func handleReceivedData(_ d: Data, pos: Int) {
       
            //unused
    }
    
    
    func handleReceivedPostData(_ d: Data) {
        //unused
    }
    
    
    
    
}
