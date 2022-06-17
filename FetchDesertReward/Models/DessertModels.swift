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
    
    var ingredients: [IngredientViewModel] {
        self.ingredientList.map({IngredientViewModel(name: $0, quantity: "")})
    }
}

struct IngredientViewModel {
    let name: String
    let quantity: String
}
