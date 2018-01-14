//
//  CropViewController.swift
//  Gardenplanner
//
//  Created by Philipp on 13.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class CropViewController: UIViewController {
    
    var delegate : DelegateCrop!
    var crop : CropsStruct!
    var bedModel : BedsModel!

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bedName: UILabel!
    @IBOutlet weak var cropDescription: UILabel!
    @IBOutlet weak var sowDate: UILabel!
    @IBOutlet weak var waterInterval: UILabel!
    @IBOutlet weak var lastPoured: UILabel!
    @IBOutlet weak var maturingTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bedModel = BedsModel()
        name.text = crop.name
        bedName.text = bedModel.getBedNameById(for: crop.bedId)
        cropDescription.text = crop.description
        sowDate.text = crop.sowDate.description
        waterInterval.text = crop.waterInterval
        lastPoured.text = crop.lastPoured
        maturingTime.text = crop.maturingTime
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
