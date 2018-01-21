//
//  RecipeTableViewCell.swift
//  HackCambridge2018
//
//  Created by Ami Zou on 1/21/18.
//  Copyright © 2018 Women Hackers. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
