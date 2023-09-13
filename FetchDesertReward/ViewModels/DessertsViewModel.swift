//
//  DesertsViewModel.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/17/22.
//

import Foundation

actor DessertsViewModel {
    
    func getDeserts() async throws -> Desserts {
        let desertFetcher = DessertFetcher()
        do {
            return try await desertFetcher.fetchDeserts()
        } catch {
            Log.networkLogger.error("Unable to retrieve deserts from API")
            throw DesertFetcherErrors.apiError(description: "Unable to retrieve deserts from API")
        }
    }
    
}
