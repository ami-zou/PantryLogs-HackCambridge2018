//
//  Food.swift
//  HackCambridge2018
//
//  Created by Ami Zou on 1/20/18.
//  Copyright © 2018 Women Hackers. All rights reserved.
//

import UIKit

class Food {
    var name: String
    var expirationDate: Date
    var daysLeft: Int
    var image: UIImage
    
    init() {
        name = "Food"
        expirationDate = Date()
        daysLeft = 0
        image = UIImage()
    }
    
    init(name: String, daysLeft: Int){
        self.name = name
        self.daysLeft = daysLeft
        self.expirationDate = Date()
        self.image = UIImage()
    }
    
    init!(name: String, daysLeft: Int, image: UIImage) {
        //test case: fail if name is empty
        if name.isEmpty {
            return nil
        }
        
        //initalization
        self.name = name
        self.daysLeft = daysLeft
        self.expirationDate = Date()
        self.image = image
    }
}

