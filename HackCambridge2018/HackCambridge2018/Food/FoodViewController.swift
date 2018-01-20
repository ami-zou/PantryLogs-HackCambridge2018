//
//  FoodViewController.swift
//  HackCambridge2018
//
//  Created by Ami Zou on 1/20/18.
//  Copyright © 2018 Women Hackers. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    var isSearching = false
    var foods = [Food]() //var foods: [Food]? = []
    var filteredFoods = [Food]()
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //***Fetching articles from News API***//
        
        tableView.dataSource = self
        tableView.delegate = self
        
        searchbar.delegate = self
        searchbar.returnKeyType = UIReturnKeyType.done
        
        loadSampleFoods()
        fetchFoods(website: "HP")
    }
    
    private func loadSampleFoods() {
        //let image1 = UIImage(cgImage: #imageLiteral(resourceName: "tomato01") as! CGImage)
        let image1 = UIImage(named: "avocado01")
        let image2 = UIImage(named: "tomato01")

        guard let food1 = Food(name: "Avocado", daysLeft: 0, image: image1!) else {
            fatalError("Unable to instantiate food1")
        }
        
        guard let food2 = Food(name: "Tomato", daysLeft: 2, image: image2!) else {
            fatalError("Unable to instantiate food1")
        }
        
        foods += [food1,food2]
        //foods.append(food1)
    }
    
    //MARK: Fetch food
    func fetchFoods(website: String){
        
    }

    //MARK: Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if searching, return filtered datafiltered
        if isSearching {
            return filteredFoods.count
        }
        
        return foods.count
        //return self.articles?.count ?? 0 //one-line if statement: or else return 0
        //return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FoodItemTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FoodItemTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
     /*
        cell.title.text = self.articles?[indexPath.item].headline //remember to unwrap it first
        cell.desc.text = self.articles?[indexPath.item].desc
        cell.imgView.downloadImage(from: (self.articles?[indexPath.item].imageUrl!)! ) //remember to unwrap
     */
        let food: Food!
        
        if isSearching {
            food = filteredFoods[indexPath.row]
        }else{
            food = foods[indexPath.row]
        }
        
        //configure the cell
        cell.foodName.text = food.name
        cell.daysLeft.text = "\(food.daysLeft) days" //String(format:"%@ days", food.daysLeft)
        cell.foodImage.image = food.image
        
        return cell
    }
    
    //MARK: Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchbar.text == nil || searchbar.text == "" {
            print("it's 103")
            
            isSearching = false
            
            view.endEditing(true)
            
            tableView.reloadData()
        } else {
            isSearching = true
            
            // filteredFoods = foods.filter({$0 == searchbar.text!})
            // filteredArray = categoryArray.filter ({$0.title.lowercased().range(of: searchText.lowercased()) != nil})
            
            let searchText = searchText.lowercased()
            filteredFoods = foods.filter({$0.name.lowercased().range(of: searchText.lowercased()) != nil})
            
            //If want more filters
            // filteredArray += self.itemArray.filter({$0. subtitle.lowercaseString.rangeOfString(searchText) != nil})
           
    
            tableView.reloadData()
        }
    }
    
   //Search Bar Extending UISearchResultsUpdating
   /*
    func searchbar(_ searchbar: UISearchBar, textDidChange searchText: String){
        
    }

    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self as! UISearchResultsUpdating
        
        searchController.searchBar.placeholder = "Search here..."
        
        searchController.searchBar.delegate = self
        
        searchController.searchBar.sizeToFit()
        
      //  tblSearchResults.tableHeaderView = searchController.searchBar
        
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    */

    /* //Initalize a view page for the specific recipe
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewVC;
        
        webVC.url = self.articles?[indexPath.item].url
        
        self.present(webVC, animated: true, completion: nil)
    }
    */

}
