//
//  BedsModel.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class BedsModel: NSObject {
    
    fileprivate var model = BedsModelSingleton.sharedInstance

}

fileprivate class BedsModelSingleton {
    fileprivate var data : [BedsStruct] = []
    static let sharedInstance = BedsModelSingleton()
}
