//
//  IPViewController.swift
//  Gardenplanner
//
//  Created by Philipp on 18.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//
import UIKit
import Google

class IPViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var ipTextField: UITextField!
    @IBOutlet weak var ipLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    fileprivate var constants : Constants!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constants = Constants()
        GIDSignIn.sharedInstance().uiDelegate = self
        saveButton.isEnabled = false
        
        //Um Back Button beim Logout zu verbergen, is ja in keinem navigation controller eingebettet (Keine ahnung wie man die bottom bar hided)
        self.navigationItem.setHidesBackButton(true, animated: false)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveToggleAuthUINotification(notification:)), name: Notification.Name("ToogleScreen"), object: nil)
        toogleUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    @IBAction func prepareForUnwind2(segue: UIStoryboardSegue) {
        print("UNWIND")
        GIDSignIn.sharedInstance().signOut()
        //performSegue(withIdentifier: "UnwindToLogin", sender: self)
    }
    
    
    @IBAction func saveIP(_ sender: Any) {
        if ipTextField.hasText{
            Constants.ip = ipTextField.text!
            performSegue(withIdentifier: "SegueLogin", sender: nil)
        }else{
            print("i was here")
            ipLabel.textColor = UIColor.red
        }
        resignFirstResponder()
    }
    
    func toogleUI(){
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
            // Signed in
            print("User is already signed in")
        } else {
            //Has to sign in with sign in button
        }
    }
    
    @objc func receiveToggleAuthUINotification(notification: Notification) {
        
        if (notification.name.rawValue == "ToogleScreen") {
            //self.toggleAuthUI()
            if notification.userInfo != nil {
                let userInfo:Dictionary<String,String> =
                    notification.userInfo as! Dictionary<String,String>
                print(userInfo["statusText"]!)
                //Sleep weil sonst versucht wird den Tab View Ctrl über den Sign in View zu legen
                //Thread.sleep(forTimeInterval: 1)
                DispatchQueue.main.async(execute: {
                    self.performSegue(withIdentifier: "Segue2TabVC", sender: nil)
                })
                
                
            }
        }
    }
    
    @IBAction func textfieldChanged(_ sender: Any) {
        saveButton.isEnabled = true
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("ToogleScreen"), object: nil)
    }
    
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
