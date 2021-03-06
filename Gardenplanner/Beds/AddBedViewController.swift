//
//  AddBedViewController.swift
//  Gardenplanner
//
//  Created by Philipp on 13.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class AddBedViewController: UIViewController, PostRequestCallback{

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var indoor: UISegmentedControl!
    @IBOutlet weak var messageLabel: UILabel!
    
    var delegate : DelegateAddBed!
    var loadingIndicator : LoadingIndicatorController!
    
    var name = ""
    var country = ""
    var zip = ""
    var city = ""
    var indoorSegment = 0
    
    var isPutRequest = false
    var idForPutRequest = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.textColor = UIColor.red
        messageLabel.text = ""
        
        nameTextField.text = name
        countryTextField.text = country
        zipTextField.text = zip
        cityName.text = city
        indoor.selectedSegmentIndex = indoorSegment
        loadingIndicator = LoadingIndicatorController(view)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAndPost(_ sender: Any) {
        let fetchDataBeds = FetchDataBeds()
        fetchDataBeds.callbachReceiver = self
        guard var zip = zipTextField.text,
            let city = cityName.text,
            let country = countryTextField.text,
            let name = nameTextField.text
            else{
           messageLabel.text = "Something went terribly wrong"
                return
        }
        if zipTextField.text == "" || cityName.text == "" || countryTextField.text == "" || nameTextField.text == "" {
            messageLabel.text = "You need to fill everything"
            return
        }
        loadingIndicator.startLoadingIndicator()
        let location = LocationsStruct(zip: zip, city: city, country: country, indoor: indoor.selectedSegmentIndex==1)
        let bed = BedsStruct(name: name, location: location)
        if isPutRequest{
            fetchDataBeds.putBed(for: Constants.userEmail, notify: "BedsLoaded", bed: idForPutRequest, bedJsonString: bed.createJSONObject(bed: bed))
        }else{
            fetchDataBeds.postBed(for: Constants.userEmail, notify: "BedsLoaded", bedJsonString: bed.createJSONObject(bed: bed))
        }
        
    }
    
    func notifyPostDone() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopLoadingIndicator()
            self.navigationController?.popViewController(animated: true)
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
