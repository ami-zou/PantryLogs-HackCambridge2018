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
    
    //TODO: Add filter function and floating recipe page
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
        
        animateTable()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //TODO: Connect with a recipe database/website
    func loadSampleRecipe(){
        let image1 = UIImage(named: "pesto_chicken_pasta_01")
        let image2 = UIImage(named: "peanut_butter_bread_01")
        
        guard let recipe1 = Recipe(name: "Pesto Chicken Pasta", time: 80, image: image1!) else {
            fatalError("can't initialize the recipe")
        }
        recipe1.updateSteps(new_steps: "Step 1\nCook pasta in a saucepan of boiling, salted water, following packet directions, until tender. Drain, reserving 1/4 cup liquid.\n\nStep 2\nReturn pasta to pan over medium-low heat. Add reserved liquid, cream, pesto, onion, chicken and tomato. Stir to combine. Cook, stirring, for 1 to 2 minutes or until heated through.\n\nStep 3\nDivide between bowls. Top with parmesan and onion. Serve with bread.")
        recipe1.updateIngredients(new_ingredients: " 350g Barilla Penne Rigate \n 300ml light cream \n 1/2 cup basil pesto\n 3 green onions, sliced \n 1/2 cups skinless shredded roast chicken (see related recipe) \n 1/2 cup drained sun-dried tomatoes, thinly sliced \n 1/3 cup finely grated parmesan cheese \n Thinly sliced green onions, to serve \n Crusty bread, to serve")
        
        guard let recipe2 = Recipe(name: "Peanut Butter Bread", time: 4, image: image2!) else {
            fatalError("can't initialize the recipe")
        }
        recipe2.updateIngredients(new_ingredients: " loaf\n jelly \n peanut butter")
        recipe2.updateSteps(new_steps: "Step 1 \nPut peanut butter and jelly on one slice of bread \n\nStep 2\nPut another slice of bread on top")
        
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
    
    //MARK: Initiate Recipe Page VC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecipePageViewController") as! RecipePageViewController;
        
        //Update content
        let indexPath = tableView.indexPathForSelectedRow
        //let currentCell = tableView.cellForRow(at: indexPath!)! as! RecipeTableViewCell
        
        let recipe: Recipe
        
        if isFiltered {
            recipe = filteredRecipes[(indexPath?.row)!]
        } else {
            recipe = recipes[(indexPath?.row)!]
        }
        
        
        recipeVC.updateRecipe(recipe: recipe)
        
        //let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewVC;
        
        //webVC.url = self.articles?[indexPath.item].url
        
        self.present(recipeVC, animated: true, completion: nil)
        //self.present(webVC, animated: true, completion: nil)
    }
    
    //MARK: Animation
    func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell

            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
    }
    
}

