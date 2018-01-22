//
//  AddCropsViewController.swift
//  Gardenplanner
//
//  Created by Philipp on 20.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class AddCropViewController: UIViewController, PostRequestCallback {
    
    

    

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var sowDateTextfield: UITextField!
    @IBOutlet weak var waterIntervalTextField: UITextField!
    @IBOutlet weak var lastPouredTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var maturingTimeTextField: UITextField!
    let datePickerSowDate = UIDatePicker()
    let datePickerLastPoured = UIDatePicker()
    
    //var delegate : AddCropDelegate!
    var callbackReceiver : PostRequestCallback!
    
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
    var loadingIndicator : LoadingIndicatorController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = name
        descriptionTextField.text = descriptionText
        sowDateTextfield.text = sowDate
        waterIntervalTextField.text = waterInterval
        lastPouredTextField.text = lastPoured
        datePickerLastPoured.minimumDate = Date()
        datePickerLastPoured.datePickerMode = UIDatePickerMode.dateAndTime
        datePickerLastPoured.addTarget(self, action: #selector(overtakeLastPoured(_:)), for: UIControlEvents.valueChanged)
        lastPouredTextField.returnKeyType = UIReturnKeyType.done
        lastPouredTextField.inputView = datePickerLastPoured
        maturingTimeTextField.text = maturingTime
        datePickerSowDate.maximumDate = Date()
        datePickerSowDate.datePickerMode = UIDatePickerMode.date
        datePickerSowDate.addTarget(self, action: #selector(overtakeSowDate(_:)), for: UIControlEvents.valueChanged)
        sowDateTextfield.returnKeyType = UIReturnKeyType.done
        sowDateTextfield.inputView = datePickerSowDate
        
        
        messageLabel.textColor = UIColor.red
        messageLabel.text = ""
        loadingIndicator = LoadingIndicatorController(view)
        
        data = BedsModel()
        

        // Do any additional setup after loading the view.
    }
    
    @objc func overtakeSowDate(_ sender: Any){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        sowDateTextfield.text = formatter.string(from: datePickerSowDate.date)
    }
    
    @objc func overtakeLastPoured(_ sender: Any){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm"
        lastPouredTextField.text = formatter.string(from: datePickerLastPoured.date)
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
        loadingIndicator.startLoadingIndicator()
        var crop = CropsStruct(name: nameTextField.text!, description: descriptionTextField.text!, sowDate: sowDateTextfield.text!, waterInterval: waterIntervalTextField.text!, lastPoured: lastPouredTextField.text!, maturingTime: maturingTimeTextField.text!)
        crop.id = idForPutRequest
        crop.bedId = self.bedId
        let fetchData = FetchDataCrops()
        fetchData.callbackReceiver = self
        
        if isPutRequest{
            fetchData.putCrop(for: Constants.userEmail, notify: "CropsLoaded", bedId: bedId, cropId: idForPutRequest, cropJsonString: crop.createJsonObject(crop: crop))
        }else{
            fetchData.postCrop(for: Constants.userEmail, notify: "CropsLoaded", bedId: bedId, cropJsonString: crop.createJsonObject(crop: crop))
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
