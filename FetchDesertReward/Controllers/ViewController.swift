//
//  ViewController.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/17/22.
//

import UIKit

class ViewController: UIViewController {
    
    var givenDessert: Meal?
    
    @IBOutlet weak var dessertName: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let dessert = self.givenDessert {
            self.dessertName.text = dessert.strMeal
        }
    }


}

