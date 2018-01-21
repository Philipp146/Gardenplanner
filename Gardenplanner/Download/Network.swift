//
//  Network.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import Foundation

class Network{
    
    enum IsRequestType {
        case get
        case delete
        case post
    }
    
    var task : URLSessionDataTask!
    var data = UserModel()
    
    func getData(from urlString : String, supervisor : NetworkSupervisor) -> Void
    {
        var request = createRequestWithoutBody(urlString: urlString)
        request.httpMethod="GET"
        makeTask(with: request, handleReceivedData: .get, supervisor)
    }
    
    func postData(to urlString: String, jsonObject json: [String : Any], supervisor : NetworkSupervisor){
        var request = createRequestWithBody(urlString: urlString, jsonObject: json)
        request.httpMethod="POST"
        makeTask(with: request, handleReceivedData : .post, supervisor)
    }
    
    func putData(to urlString: String, jsonObject json: [String : Any], supervisor: NetworkSupervisor){
        var request = createRequestWithBody(urlString: urlString, jsonObject: json)
        request.httpMethod="PUT"
        makeTask(with: request, handleReceivedData: .post, supervisor)
    }
    
    func deleteData(from urlString: String, supervisor: NetworkSupervisor){
        var request = createRequestWithoutBody(urlString: urlString)
        request.httpMethod = "DELETE"
        makeTask(with: request, handleReceivedData: .delete, supervisor)
    }
    
    
    
    func createUrlRequest(urlString : String) -> URLRequest{
        let url = URL(string: urlString)!
        let request = URLRequest(url : url)
        return request
    }
    
    func createRequestWithBody(urlString : String, jsonObject json: [String : Any]) -> URLRequest{
        var request = createUrlRequest(urlString: urlString)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Constants.userToken, forHTTPHeaderField: "token")
        dump(request.httpBody)
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [])
        dump(request.httpBody)
        return request
    }
    
    func createRequestWithoutBody(urlString : String)-> URLRequest{
        var request = createUrlRequest(urlString: urlString)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Constants.userToken, forHTTPHeaderField: "token")
        return request
    }

    fileprivate func makeTask(with request : URLRequest, handleReceivedData isRequestType : IsRequestType, _ supervisor: NetworkSupervisor){
        let task = URLSession.shared.dataTask(with: request){
            data,response,error in
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
            
            if isRequestType == .get{
                supervisor.handleReceivedData(data)
            }else if isRequestType == .post{
                supervisor.handleReceivedPostData(data)
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
