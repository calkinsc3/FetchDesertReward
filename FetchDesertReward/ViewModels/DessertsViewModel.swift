//
//  DesertsViewModel.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/17/22.
//

import Foundation

final class DessertsViewModel {
    
    var deserts = Desserts.desertPlaceHolder
    var placeHolderDeserts = Desserts.desertPlaceHolder
    
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
