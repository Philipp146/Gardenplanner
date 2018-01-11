//
//  WeatherModel.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class WeatherModel: NSObject {
    
    fileprivate var model = WeatherModelSingleton.sharedInstance

}

fileprivate class WeatherModelSingleton{
    fileprivate var data : [WeatherStruct] = []
    static let sharedInstance = WeatherModelSingleton()
}
