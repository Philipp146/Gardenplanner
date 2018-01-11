//
//  NetworkSupervisor.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

protocol NetworkSupervisor : NSObjectProtocol{
    
     func handleReceivedData (_ d:AnyObject) -> Void
}
