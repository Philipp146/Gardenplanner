//
//  LoginViewController.swift
//  Gardenplanner
//
//  Created by Normen Krug on 18.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class LoginViewController : UIViewController, WKNavigationDelegate{
    
    var webView: WKWebView!
    var urlBuilder: UrlBuilder!
    var networkHelper: Network!
    
    @IBAction func login(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueTab", sender: nil)
    }
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        urlBuilder = UrlBuilder()
        networkHelper = Network()
        var url = urlBuilder.createBaseUrl() + "/user"
        //Network.postData(url,nil,)
        //webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
