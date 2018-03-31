//
//  Recipe.swift
//  HackCambridge2018
//
//  Created by Ami Zou on 1/21/18.
//  Copyright © 2018 Women Hackers. All rights reserved.
//

import UIKit

class Recipe: NSObject {
    var name: String?
    var desc: String?
    var image: UIImage?
    var time: Int?
    var steps: String?
    var ingredients: String?
    
    override init() {
        super.init()
    }
    
    init!(name: String, time: Int, image: UIImage){
        self.name = name
        self.desc = ""
        self.image = image
        self.time = time
        self.steps = ""
        self.ingredients = ""
    }
    
    func updateIngredients(new_ingredients: String){
        self.ingredients = new_ingredients
    }
    
    func updateSteps(new_steps: String){
        self.steps = new_steps
    }
}
