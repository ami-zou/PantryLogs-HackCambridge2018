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
    @IBOutlet weak var expiracy: UITextField!
    //@IBOutlet weak var pickerView: UIPickerView!
    //Some other variables
    
    var food: Food?
    var days: String!
    //var dateArray = [Int]()
    
  //  @IBAction func Done(_ sender: Any) {
        
  //      self.dismiss(animated: true, completion: nil)
  //  }

    override func viewDidLoad() {
        super.viewDidLoad()

        //Initialize the parmeters
        //foodName.text = food?.name
        image.image = food?.image
        expiracy.text = "\(food?.daysLeft ?? 0)"
        //some other initiations
       
    /*Initialize pickerView
        dateArray = [0, 1, 2, 3, 4, 5]
        self.pickerView.dataSource = self as? UIPickerViewDataSource
        self.pickerView.delegate = self as? UIPickerViewDelegate
    */
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newDaysLeft = expiracy.text {
            days = expiracy.text
        }
    }
    
    //MARK: - Pickerview method
    /*
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dateArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> Int? {
        return dateArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //update database
        //self.labelFruit.text = dateArray[row]
    }
*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
