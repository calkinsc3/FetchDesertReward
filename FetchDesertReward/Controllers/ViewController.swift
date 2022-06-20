//
//  ViewController.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/17/22.
//

import UIKit

enum DesertSectionSelection {
    case instrucitons, ingredients, unknown
    
    init() {
        self = .unknown
    }
}

class ViewController: UIViewController {
    
    let desertDetailViewModel = DesertDetailViewModel()
    
    var givenDessert: Meal?
    
    private var dessertDetail: MealDetail?
    private var dessertSelection = DesertSectionSelection()
    
    @IBOutlet weak var dessertName: UILabel!
    @IBOutlet weak var ingredientsButton: UIButton!
    
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
                dessertDetail = try await self.desertDetailViewModel.getDesertDetails(withMealId: mealID)
                self.dessertName.text = dessertDetail?.mealName
                // FIXME: if the ingredient data is incorrect hide ingredient button
                if let ingredients = dessertDetail?.mealIngredients {
                    self.ingredientsButton.isHidden = ingredients.count == 0
                }
                
            } catch {
                Log.networkLogger.error("Unable to retrieve desert details from API")
            }
        }
    }
    
    // MARK: - Button Actions
    @IBAction func showInstrucitons(_ sender: UIButton) {
        
        self.dessertSelection = .instrucitons
        self.performSegue(withIdentifier: "instructionsSegue", sender: sender)
        
    }
    
    @IBAction func showIngredients(_ sender: UIButton) {
        
        self.dessertSelection = .ingredients
        self.performSegue(withIdentifier: "ingredientsSegue", sender: sender)
    }
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let dessertDetail = dessertDetail else {
            return
        }

        
        if segue.identifier == "instructionsSegue",
            let instructionList = segue.destination as? InstructionList,
            let dessetInstrucitons = dessertDetail.mealInstructionsList {
            // set instruciton list
            instructionList.givenInstructions = dessetInstrucitons
        }
        
        
        if segue.identifier == "ingredientsSegue",
           let ingredientList  = segue.destination as? IngredientList,
           let dessertIngredients = dessertDetail.mealIngredients {
            //set ingredients
            ingredientList.ingredients = dessertIngredients
            
        }
    }


}

