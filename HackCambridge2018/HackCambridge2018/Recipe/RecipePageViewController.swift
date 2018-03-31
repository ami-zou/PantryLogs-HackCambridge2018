//
//  RecipePageViewController.swift
//  HackCambridge2018
//
//  Created by Ami Zou on 1/21/18.
//  Copyright © 2018 Women Hackers. All rights reserved.
//

import UIKit

class RecipePageViewController: UIViewController {
    @IBOutlet weak var recipeImage : UIImageView!
    @IBOutlet weak var recipeName: UILabel!
   // @IBOutlet weak var tabIng: UITabBarItem!
   // @IBOutlet weak var tabStep: UITabBarItem!
   // @IBOutlet weak var ingredients: UIView!
   // @IBOutlet weak var steps: UIView!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    
    var recipe: Recipe?
    
    @IBAction func Dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeImage.image = recipe?.image
        recipeName.text = recipe?.name
        segment.selectedSegmentIndex = 0
        content.text = recipe?.ingredients
        //update Recipe
        
        //     self.navigationController?.interactivePopGestureRecognizer?.delegate = self as! UIGestureRecognizerDelegate
        //     self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func updateRecipe(recipe: Recipe){
        self.recipe = recipe
        
//        update()
    }
 /*
    func update(){
        recipeImage?.image = recipe?.image
        recipeName?.text = recipe.name
        content.text = recipe?.ingredients
        
        self.loadView()
    }
*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func indexChange(_ sender: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            content.text = recipe?.ingredients
        case 1:
            content.text = recipe?.steps
        default:
            ()
        }
    }
 
/*
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
 
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                 self.dismiss(animated: true, completion: nil)
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
     
     */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
