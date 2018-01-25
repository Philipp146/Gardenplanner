//
//  IngredientsViewController.swift
//  Gardenplanner
//
//  Created by Normen Krug on 22.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit


class IngredientsViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var IngredientLabel: UILabel!
    var recipe: RecipesStruct!
    var networkHelper = Network()
    var fetchDetail = FetchIngredient()
    var delegate = IngredientsDelegate()
    var datasource = IngredientsDataSource()
    
    @IBOutlet weak var ImageView: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = datasource
        tableView.delegate = delegate
        ImageView.image = recipe.pictures
        //Network call
        // Do any additional setup after loading the view.
        fetchDetail.getDetailForRecipe(id:recipe.recipeId)
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(handleNotification), name: NSNotification.Name("detail"), object: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func handleNotification(){
        datasource.ingredients = fetchDetail.ingStrings
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
