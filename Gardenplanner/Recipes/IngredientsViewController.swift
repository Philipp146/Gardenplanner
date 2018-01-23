//
//  IngredientsViewController.swift
//  Gardenplanner
//
//  Created by Normen Krug on 22.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit


class IngredientsViewController: UIViewController {

    var crop: CropsStruct!
    var networkHelper = Network()
    
    @IBOutlet weak var Ingredient5: UILabel!
    @IBOutlet weak var Ingredient4: UILabel!
    @IBOutlet weak var Ingredient3: UILabel!
    @IBOutlet weak var Ingredient2: UILabel!
    @IBOutlet weak var Ingredient1: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
