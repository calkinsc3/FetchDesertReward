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
            Log.modelLogger.info("Unable to unwrap meal details or get meal name.")
            return nil
        }
        
        return mealName ?? nil
    }
    
    var mealInstruction: String? { // TODO: Possilby make an array
        
        guard let givenMeal = self.meals.first,
                let mealInstruction = givenMeal["strInstructions"] else {
            Log.modelLogger.info("Unable to unwrap meail or get meal instructions")
            return nil
        }
        
        return mealInstruction ?? nil
    }
    
    
    var completeInstructions: [MealIngredients]? {
        
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
        
        // TODO: Check counts?
        //zip both sorted arrays into an associated dictionary
        let completeInstructions = Dictionary(uniqueKeysWithValues: zip(filteredIngredients, filteredMesurements))
        
        //map associated dictionary into structured model objects
        return completeInstructions.map({MealIngredients(name: $0.key, quantity: $0.value)})
        
    }
}

// MARK: - MealViewModel
//clean up the return from MealDetail into a better structure
struct MealViewModel {
    let meallID: Int
    let name: String
    let drinkAlternative: String?
    let category: String
    let instructions: String // TODO: Make structured data
    let thumbNail: URL?
    let giveTags: String? //strcutred data?
    let youTubeLink: URL?
    let ingredientList: [String]
    let measurementList: [String]
    let mealSource: URL?
    let mealImageSource: URL?
    let dataModified: Date?
    
    var ingredients: [MealIngredients] {
        self.ingredientList.map({MealIngredients(name: $0, quantity: "")})
    }
}

struct MealIngredients {
    let name: String
    let quantity: String
}

