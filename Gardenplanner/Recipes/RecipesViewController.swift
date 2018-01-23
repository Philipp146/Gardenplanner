//
//  RecipesViewController.swift
//  Gardenplanner
//
//  Created by Philipp on 11.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var fetchHelper = FetchDataRecipe()
    var networkHelper = Network()
    var crop: CropsStruct!
    var notifyString = "recipesList"
    var delegate = SearchBarDelegate()
    var fetchPic = FetchPictures()

    
    var dataSource : RecipeTableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = delegate
        dataSource = RecipeTableViewDataSource()
        tableView.dataSource = dataSource
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(searchBarNotification), name: NSNotification.Name("searchBar"), object: nil)
        nc.addObserver(self, selector: #selector(refreshImages), name: NSNotification.Name("pictures"), object: nil)

        if crop != nil{
            getRecipesForCrop(name: crop.name)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func getRecipesForCrop(name: String){
        fetchHelper.getRecipes(name: name)
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(handleNotification), name: NSNotification.Name(notifyString), object: nil)
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleNotification(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.loadPictures()
        }
        
    }
    
    func loadPictures(){
        var recipes = ModelSingleton.sharedInstance.recipes
        
        for i in 0..<recipes.count {
            let request = networkHelper.createRequestWithoutBody(urlString: recipes[i].imageUrl)
            print(recipes[i].imageUrl)
            networkHelper.makeTask(with: request, supervisor: fetchPic , pos: i)
        }
    }
    
    @objc func refreshImages(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func searchBarNotification(){
        //error handling
        getRecipesForCrop(name: searchBar!.text!)
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
