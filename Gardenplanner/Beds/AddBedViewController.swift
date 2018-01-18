//
//  AddBedViewController.swift
//  Gardenplanner
//
//  Created by Philipp on 13.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class AddBedViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var indoor: UISegmentedControl!
    @IBOutlet weak var messageLabel: UILabel!
    
    var delegate : DelegateAddBed!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.textColor = UIColor.red
        messageLabel.text = ""

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAndPost(_ sender: Any) {
        let fetchDataBeds = FetchDataBeds()
        guard var zip = zipTextField.text,
            let city = cityName.text,
            let country = countryTextField.text,
            let name = nameTextField.text
            else{
           messageLabel.text = "You need to fill everything"
                return
        }
        let location = LocationsStruct(zip: zip, city: city, country: country, indoor: indoor.selectedSegmentIndex==1)
        let bed = BedsStruct(name: name, location: location)
        fetchDataBeds.postBed(for: "maxi@sonntags.net", notify: "POST", bedJsonString: bed.createJSONObject(bed: bed))
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
