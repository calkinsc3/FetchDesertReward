//
//  DesertDetailViewModel.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/19/22.
//

import Foundation

final class DesertDetailViewModel {
    
    func getDesertDetails(withMealId mealID: String) async throws -> MealDetail {
        let desertFetcher = DessertFetcher()
        do {
            return try await desertFetcher.fetchDesertDetails(withMealId: mealID)
        } catch {
            Log.networkLogger.error("Unable to retrieve desert details from API")
            throw DesertFetcherErrors.apiError(description: "Unable to retrieve desert details from API")
        }
    }
    
}
