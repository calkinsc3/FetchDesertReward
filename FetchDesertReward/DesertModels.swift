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
