//
//  FoodItemPopUpViewController.swift
//  HackCambridge2018
//
//  Created by Ami Zou on 3/31/18.
//  Copyright © 2018 Women Hackers. All rights reserved.
//

import UIKit

class FoodItemPopUpViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    //Some other variables
    
    var food: Food?
    
    @IBAction func Done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //Initialize the parmeters
        //foodName.text = food?.name
        image.image = food?.image
        //some other initiations
        
         
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
