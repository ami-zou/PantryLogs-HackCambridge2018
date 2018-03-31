//
//  FoodItemPopUpViewController.swift
//  HackCambridge2018
//
//  Created by Ami Zou on 3/31/18.
//  Copyright © 2018 Women Hackers. All rights reserved.
//

import UIKit

class FoodItemPopUpViewController: UIViewController {
    @IBOutlet weak var PopView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var expiracy: UITextField!
    //@IBOutlet weak var pickerView: UIPickerView!
    //Some other variables
    
    var food: Food?
    var days: Int!
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
        days = food?.daysLeft
        //some other initiations
       
    /*Initialize pickerView
        dateArray = [0, 1, 2, 3, 4, 5]
        self.pickerView.dataSource = self as? UIPickerViewDataSource
        self.pickerView.delegate = self as? UIPickerViewDelegate
    */
        self.PopView.addGestureRecognizer(UITapGestureRecognizer(target: self.PopView, action: #selector(UIView.endEditing(_:))))
       // self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:”)))
      
        //UPDATE: In fact, can just use number pad instead - no need to valid input as Int nor send alert!
        self.expiracy.keyboardType = UIKeyboardType.decimalPad
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newDaysLeft = expiracy.text {
            
            if Int(newDaysLeft) != nil {
                days = Int(newDaysLeft)
            }else{
                //alert
                //print("wrong input")
                let alert = UIAlertController(title: "Invalid Input", message: "Please type a valid number of left days", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Oki Doki", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
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
