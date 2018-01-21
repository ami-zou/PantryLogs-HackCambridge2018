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
        
        animateTable()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        //let cells = tableView.visibleCells()
        
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            
            /*Swift 2
            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options:nil , animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
            }, completion: nil)
            */
            
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
    }
    
}

