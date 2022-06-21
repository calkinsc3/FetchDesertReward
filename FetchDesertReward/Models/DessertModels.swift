//
//  DesertModels.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/17/22.
//

import Foundation


// MARK: - Deserts
struct Desserts: Decodable {
    let meals: [Meal]
    
    //Only for use in prototypeing and SwiftUI Previews
#if DEBUG
    static let desertPlaceHolder = Self(meals: [Meal.mealPlaceholder1,
                                                Meal.mealPlaceholder2,
                                                Meal.mealPlaceholder3,
                                                Meal.mealPlaceholder4])
#endif
}

// MARK: - Meal
struct Meal: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    //Only for use in prototypeing and SwiftUI Previews
#if DEBUG
    static let mealPlaceholder1 = Self(strMeal: "Apam balid", strMealThumb: "URL for Thumb", idMeal: "53049")
    static let mealPlaceholder2 = Self(strMeal: "Apple & Blackberry Crumble", strMealThumb: "URL for Thumb", idMeal: "52893")
    static let mealPlaceholder3 = Self(strMeal: "Apple Frangipan Tart", strMealThumb: "URL for Thumb", idMeal: "52768")
    static let mealPlaceholder4 = Self(strMeal: "Bakewell tart", strMealThumb: "URL for Thumb", idMeal: "52767")
#endif
}


// MARK: - MealDetail
struct MealDetail: Decodable {
    
    let meals: [[String: String?]]
    
    
    // TODO: Possibly move comp props to VM
    var mealName: String? {
        
        guard let givenMeal = self.meals.first, let mealName = givenMeal["strMeal"] else {
            Log.modelLogger.debug("Unable to unwrap meal details or get meal name.")
            return nil
        }
        
        return mealName ?? nil
    }
    
    var mealInstruction: String? {
        
        guard let givenMeal = self.meals.first,
              let mealInstruction = givenMeal["strInstructions"] else {
            Log.modelLogger.debug("Unable to unwrap meal or get meal instructions")
            return nil
        }
        
        return mealInstruction ?? nil
    }
    
    var mealInstructionsList: [String]? {
        
        guard let givenMealInstructions = self.mealInstruction else {
            Log.modelLogger.debug("Unable to unwrap meal instructions")
            return nil
        }
        
        // Need to convert subSequence array to an array of strings for return
        return givenMealInstructions.split(whereSeparator: \.isNewline).map({String($0)})
        
    }
    
    
    var mealIngredients: [MealIngredients]? {
        
        guard let givenMeal = self.meals.first else {
            Log.viewModelLogger.info("Unable to unwrap meal details.")
            return nil
        }
        
        //filter the ingredients list
        let filteredIngredients = givenMeal.filter({$0.key.contains("strIngredient")})
            .sorted(by: {$0.key < $1.key})
            .compactMap({$0.value}) //remove nil values
            .filter({$0 != ""}) // remove empty strings
        //filter the quantity list
        let filteredMesurements = givenMeal.filter({$0.key.contains("strMeasure")})
            .sorted(by: {$0.key < $1.key})
            .compactMap({$0.value})
            .filter({$0 != ""})
            .filter({$0 != " "})
        
        // FIXME: Beaver Trail Issue
        // some of the ingredients are not unique
        // make them Sets to drop dups
        // if they do not match return nil
        let uniqueIngredients = Set(filteredIngredients)
        //let uniqueMeasures = Set(filteredMesurements)
        
        //make sure the ingredients are unique and the ingredient and measure count are the same
        if filteredIngredients.count == uniqueIngredients.count && uniqueIngredients.count == filteredMesurements.count {
            let completeInstructions = Dictionary(uniqueKeysWithValues: zip(filteredIngredients, filteredMesurements))
            
            //map associated dictionary into structured model objects
            return completeInstructions.map({MealIngredients(name: $0.key, quantity: $0.value)}).sorted(by: {$0.name < $1.name})
            
        } else if filteredIngredients.count == filteredMesurements.count { // keys are not unique. they cannot be zipped. build manually
            
            var returnedIngredients: [MealIngredients] = []
            let namedIngredients = filteredIngredients.map({MealIngredients(name: $0, quantity: "")})
            
            for (index, ingredient) in namedIngredients.enumerated() {
                returnedIngredients.append(MealIngredients(name: ingredient.name, quantity: filteredMesurements[index]))
            }
            
            return returnedIngredients
            
        } else {
            return nil
        }
        
    }
    
    var mealIngrients: String? {
        
        guard let givenIngredients = self.mealIngredients else {
            Log.viewModelLogger.info("Unable to unwrap meal details.")
            return nil
        }
        
        return givenIngredients.map({$0.description}).joined(separator: "\n")
    }
}


struct MealIngredients: CustomStringConvertible {
    var name: String
    var quantity: String
    
    var description: String {
        "\(name) : \(quantity)"
    }
}

