//
//  ViewController.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/17/22.
//

import UIKit

class ViewController: UIViewController {
    
    let desertDetailViewModel = DesertDetailViewModel()
    
    var givenDessert: Meal?
    
    private var dessertDetail: MealDetail?
    
    @IBOutlet weak var dessertName: UILabel!
    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let dessert = self.givenDessert {
            self.dessertName.text = dessert.strMeal
            //gather desert details
            self.gatherDessertDetails(withMealId: dessert.idMeal)
        }
    }
    
    // MARK: Helpers
    func gatherDessertDetails(withMealId mealID: String) {
        Task {
            do {
                let givenDessertDetail = try await self.desertDetailViewModel.getDesertDetails(withMealId: mealID)
                self.dessertName.text = givenDessertDetail.mealName
                self.instructions.text = givenDessertDetail.mealInstruction
                self.ingredients.text = givenDessertDetail.mealIngrients ?? "Not given"
                
            } catch {
                Log.networkLogger.error("Unable to retrieve desert details from API")
            }
        }
    }


}

