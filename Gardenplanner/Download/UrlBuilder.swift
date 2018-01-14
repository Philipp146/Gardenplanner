//
//  UrlBuilder.swift
//  Gardenplanner
//
//  Created by Philipp on 14.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class UrlBuilder: NSObject {
    
    func createBaseUrl() -> String
    {
        let urlString = "http://" + Constants.ip + ":8080/Gartenplaner"
        return urlString

    }
    
    func addPath(_ query : String, _ url : String) -> String{
        let newUrl = url + "/" + query
        return newUrl
    }
    
//    func createBaseUrl() -> URLComponents
//    {
//        var uc = URLComponents()
//        uc.scheme = "http"
//        uc.host = Constants.ip + ":8080"
//        uc.path = "/Gartenplaner"
//
//        return uc
//    }

}
