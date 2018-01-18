//
//  IPViewController.swift
//  Gardenplanner
//
//  Created by Philipp on 18.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class IPViewController: UIViewController {

    @IBOutlet weak var ipTextField: UITextField!
    @IBOutlet weak var ipLabel: UILabel!
    
    fileprivate var constants : Constants!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constants = Constants()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveIP(_ sender: Any) {
        if ipTextField.hasText{
            Constants.ip = ipTextField.text!
            performSegue(withIdentifier: "SegueLogin", sender: nil)
        }else{
            print("i was here")
            ipLabel.textColor = UIColor.red
        }
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
