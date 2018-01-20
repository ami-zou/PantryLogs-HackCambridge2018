//
//  FoodViewController.swift
//  HackCambridge2018
//
//  Created by Ami Zou on 1/20/18.
//  Copyright © 2018 Women Hackers. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    //var foods: [Food]? = []
    var foods = [Food]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //***Fetching articles from News API***//
        loadSampleFoods()
        fetchFoods(website: "HP")
    }
    
    private func loadSampleFoods() {
        //let image1 = UIImage(cgImage: #imageLiteral(resourceName: "tomato01") as! CGImage)
        let image1 = UIImage(named: "tomato01")
        
        guard let food1 = Food(name: "tomato", daysLeft: 0, image: image1!) else {
            fatalError("Unable to instantiate food1")
        }
        
        //foods += [food1]
        foods.append(food1)
    }
    
    //MARK: Fetch food
    func fetchFoods(website: String){
        
    }

    //MARK: Table View
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodItemTableViewCell", for: indexPath) as! FoodItemTableViewCell //type
     /*
        cell.title.text = self.articles?[indexPath.item].headline //remember to unwrap it first
        cell.desc.text = self.articles?[indexPath.item].desc
        cell.imgView.downloadImage(from: (self.articles?[indexPath.item].imageUrl!)! ) //remember to unwrap
     */
        let food = foods[indexPath.row]
        
        //configure the cell
        cell.foodName.text = food.name
        cell.daysLeft.text = "0 days" //String(format:"%@ days", food.daysLeft)
        cell.foodImage.image = food.image
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foods.count
        //return self.articles?.count ?? 0 //one-line if statement: or else return 0
        //return 0
    }

    /* //Initalize a view page for the specific recipe
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewVC;
        
        webVC.url = self.articles?[indexPath.item].url
        
        self.present(webVC, animated: true, completion: nil)
    }
    */

}
