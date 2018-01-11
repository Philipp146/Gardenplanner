//
//  PlantsModel.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class PlantsModel: NSObject {
    
    fileprivate var model = PlantsModelSingleton.sharedInstance

}

fileprivate class PlantsModelSingleton{
    
    fileprivate var data : [PlantsStruct] = []
    static let sharedInstance = PlantsModelSingleton()
}
