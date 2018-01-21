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
        tableView.tableFooterView = UIView(frame: CGRect.zero) //Hiding blank cells.
        tableView.separatorInset = UIEdgeInsets.zero
        
        tableView.dataSource = self
        tableView.delegate = self
        
        searchbar.delegate = self
        searchbar.returnKeyType = UIReturnKeyType.done
        
        loadSampleFoods()
        fetchFoods(website: "HP")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        var urlRequest = URLRequest(url: URL(string:"https://fierce-gorge-21914.herokuapp.com/obj")! ) //put a string URL inside -- now: https://fierce-gorge-21914.herokuapp.com/obj --- real-time object list
         
        var urlNewsRequest = URLRequest(url: URL(string:"https://newsapi.org/v1/articles?source=the-huffington-post&sortBy=top&apiKey=3e56f15fb422469082480f36fa7609c4")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            do { //see upper comment for Json example
               //let data = str.data(using: String.Encoding.utf8, allowLossyConversion: false)!

                if let jsonData = try? JSONSerialization.data(withJSONObject: (Any).self, options: []) {
                    if let content = String(data: json, encoding: .utf8) {
                        print(content)
                    }
                }
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let foodsFromJson = json["objects"] as? [[String : AnyObject]]{
                    for foodFromJson in foodsFromJson{
                        let food = Food()
                        if let type = foodFromJson["obj_prediction"] as? String,
                            let exp = foodFromJson["obj_exp"] as? String
                            {
                            food.name = type
                            food.daysLeft = Int(exp)!
                        }
                        self.foods.append(food)
                    }
                }
           
            //Test case for article
                if let foodsFromJson = json["articles"] as? [[String : AnyObject]]{
                    for foodFromJson in foodsFromJson{
                        let food = Food()
                        if let author = foodFromJson["author"] as? String
                        {
                            food.name = author
                        }
                        self.foods.append(food)
                    }
                }
                
                DispatchQueue.main.async { //run in the main thread in stead of in back
                    self.tableView.reloadData() //reload data
                }
                
            } catch let error{
                print(error)
            }
        }
        
        task.resume() //resume the task
    }
    
    //MARK: Refresh data by adding Pull-to-Refresh func //TODO

    //MARK: Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        //return 4
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
            fatalError("The dequeued cell is not an instance of FoodItemTableViewCell.")
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
    
    //MARK: Swipe Cell
    //Enable cell editing methods.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            //self.isEditing = false
            print("edit button tapped")
        }
        edit.backgroundColor = UIColor.lightGray
    
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            //self.isEditing = false
            
            //delete item
            self.foods.remove(at: indexPath.row)
            self.tableView.reloadData()
            print("delete button tapped")
        }
        delete.backgroundColor = UIColor.red
  
        return [delete, edit]
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
