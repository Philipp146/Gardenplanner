//
//  Network.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import Foundation

class Network{
    
    var task : URLSessionDataTask!
    var data = UserModel()
    
    func getData(from urlString : String, supervisor : NetworkSupervisor) -> Void
    {
        var request = createRequestWithoutBody(urlString: urlString)
        request.httpMethod="GET"
        makeTask(with: request, handleReceivedData: true, supervisor)
    }
    
    func postData(to urlString: String, jsongString json: String, supervisor : NetworkSupervisor){
        var request = createRequestWithBody(urlString: urlString, jsonString: json)
        request.httpMethod="POST"
        makeTask(with: request, handleReceivedData : false, supervisor)
    }
    
    func putData(to urlString: String, jsonString json: String, supervisor: NetworkSupervisor){
        var request = createRequestWithBody(urlString: urlString, jsonString: json)
        request.httpMethod="PUT"
        makeTask(with: request, handleReceivedData: false, supervisor)
    }
    
    func deleteData(from urlString: String, supervisor: NetworkSupervisor){
        var request = createRequestWithoutBody(urlString: urlString)
        request.httpMethod = "DELETE"
        makeTask(with: request, handleReceivedData: false, supervisor)
    }
    
    
    
    func createUrlRequest(urlString : String) -> URLRequest{
        let url = URL(string: urlString)!
        let request = URLRequest(url : url)
        return request
    }
    
    func createRequestWithBody(urlString : String, jsonString json: String) -> URLRequest{
        var request = createUrlRequest(urlString: urlString)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Test123", forHTTPHeaderField: "token")
        request.httpBody = json.data(using: .utf8)
        return request
    }
    
    func createRequestWithoutBody(urlString : String)-> URLRequest{
        var request = createUrlRequest(urlString: urlString)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Test123", forHTTPHeaderField: "token")
        return request
    }

    fileprivate func makeTask(with request : URLRequest, handleReceivedData isGetRequest : Bool, _ supervisor: NetworkSupervisor){
        let task = URLSession.shared.dataTask(with: request){
            data,response,error in
            if isGetRequest{
                supervisor.handleReceivedData(data as AnyObject)
            }
            // check for fundamental networking error
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            // check for http errors
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }
    
    
    
    func cancel () -> Void
    {
        task.cancel()
    }
}
