//
//  IngredientCell.swift
//  Gardenplanner
//
//  Created by Normen Krug on 25.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import Foundation
import UIKit



class IngredientCell: UITableViewCell{
    @IBOutlet weak var IngredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
