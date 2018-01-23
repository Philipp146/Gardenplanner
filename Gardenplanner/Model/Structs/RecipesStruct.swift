//
//  RecipesStruct.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

struct RecipesStruct {
    
    var recipeId: String
    var title: String
    var imageUrl: String
    var socialRank: Double
    var pictures: UIImage?
    
    
}
extension RecipesStruct{
    init?(withJsonForName: [String : Any]) {
        guard let recipeId = withJsonForName["recipe_id"] as? String,
            let title = withJsonForName["title"] as? String,
            let imageUrl = withJsonForName["image_url"] as? String,
            let socialRank = withJsonForName["social_rank"] as? Double
            else {
                return nil
        }
        
        self.recipeId = recipeId
        self.title = title //Muss noch ausgelesen werden
        self.imageUrl = imageUrl
        self.socialRank = socialRank
        self.pictures = nil
    }
}

