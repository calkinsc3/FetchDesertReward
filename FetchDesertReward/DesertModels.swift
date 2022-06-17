//
//  DesertModels.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/17/22.
//

import Foundation


// MARK: - Deserts
struct Deserts: Decodable {
    let meals: [Meal]
}

// MARK: - Meal
struct Meal: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
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

