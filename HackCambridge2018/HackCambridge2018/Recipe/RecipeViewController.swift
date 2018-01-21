//
//  SecondViewController.swift
//  HackCambridge2018
//
//  Created by Ami Zou on 1/20/18.
//  Copyright © 2018 Women Hackers. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var floatItems: UIImage!
    
    //recipe page
    
    var recipes = [Recipe]()
    var filteredRecipes = [Recipe]()
    var isFiltered = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadSampleRecipe()
    }
    
    func loadSampleRecipe(){
        let image1 = UIImage(named: "pesto_chicken_pasta_01")
        let image2 = UIImage(named: "peanut_butter_bread_01")
        
        guard let recipe1 = Recipe(name: "Pesto Chicken Pasta", time: 80, image: image1!) else {
            fatalError("can't initialize the recipe")
        }
        
        guard let recipe2 = Recipe(name: "Peanut Butter Bread", time: 4, image: image2!) else {
            fatalError("can't initialize the recipe")
        }
        
        recipes += [recipe1, recipe2]
    }

  
    //MARK: Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered {
            return filteredRecipes.count
        } else {
            return recipes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RecipeTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecipeTableViewCell else {
                fatalError("The dequeued cell is not an instance of RecipeTableViewCell.")
        }
        
        let recipe: Recipe
        
        if isFiltered {
            recipe = filteredRecipes[indexPath.row]
        } else {
            recipe = recipes[indexPath.row]
        }
        
        cell.name.text = recipe.name
        cell.recipeImage.image = recipe.image
        cell.time.text = "ET: \(recipe.time ?? 0) mins"
        
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

