//
//  AddCropsViewController.swift
//  Gardenplanner
//
//  Created by Philipp on 20.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class AddCropViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var sowDateTextfield: UITextField!
    @IBOutlet weak var waterIntervalTextField: UITextField!
    @IBOutlet weak var lastPouredTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var maturingTimeTextField: UITextField!
    
    //var delegate : AddCropDelegate!
    
    var isPutRequest = false
    var idForPutRequest = 0
    var bedId = 0
    var data : BedsModel!
    
    var name = ""
    var descriptionText = ""
    var sowDate = ""
    var waterInterval = ""
    var lastPoured = ""
    var maturingTime = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = name
        descriptionTextField.text = descriptionText
        sowDateTextfield.text = sowDate
        waterIntervalTextField.text = waterInterval
        lastPouredTextField.text = lastPoured
        maturingTimeTextField.text = maturingTime
        
        messageLabel.textColor = UIColor.red
        messageLabel.text = ""
        
        data = BedsModel()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAndPost(_ sender: Any) {
        if nameTextField.text == "" || descriptionTextField.text == "" || sowDateTextfield.text == "" ||
            waterIntervalTextField.text == "" || lastPouredTextField.text == "" || maturingTimeTextField.text == ""{
            messageLabel.text = "Please fill everything and correct"
            return
        }
        
        var crop = CropsStruct(name: nameTextField.text!, description: descriptionTextField.text!, sowDate: sowDateTextfield.text!, waterInterval: waterIntervalTextField.text!, lastPoured: lastPouredTextField.text!, maturingTime: maturingTimeTextField.text!)
        crop.id = idForPutRequest
        crop.bedId = self.bedId
        let fetchData = FetchDataCrops()
        
        if isPutRequest{
            fetchData.putCrop(for: "maxi@sonntags.net", notify: "CropsLoaded", bedId: bedId, cropId: idForPutRequest, cropJsonString: crop.createJsonObject(crop: crop))
        }else{
            fetchData.postCrop(for: "maxi@sonntags.net", notify: "CropsLoaded", bedId: bedId, cropJsonString: crop.createJsonObject(crop: crop))
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
