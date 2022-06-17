//
//  DesertFetcher.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/17/22.
//

import Foundation


final class DessertFetcher {
    
    private var session: URLSession
    
    init() {
        
        self.session = URLSession(configuration: .default)
        
    }
    
    // MARK: - Get Deserts from API
    func fetchDeserts() async throws -> Desserts {
        
        //assemble URL
        guard let url = self.makeComponentsForDesert().url else {
            throw DesertFetcherErrors.urlError(description: "Could not assemble URL for Deserts")
        }
        
        let (data, response) = try await self.session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw DesertFetcherErrors.apiError(description: "Returned a non-200")
        }
        
        do {
            return try JSONDecoder().decode(Desserts.self, from: data)
        } catch let error {
            throw DesertFetcherErrors.decoding(description: "Error decoding: \(error)")
        }
    }
    

    // MARK: - Get Desert Details from API
    
    
}



// MARK: - Endpoint Builder
private extension DessertFetcher {
    
    func makeComponentsForDesert() -> URLComponents {
        
        var components = URLComponents()
        
        components.scheme = MEAL_API.schema
        components.host = MEAL_API.host
        components.path = MEAL_API.desertPath
        components.queryItems = [URLQueryItem(name: "c", value: "Dessert")] //?c=Dessert
        
        return components
    
    }
    
    func makeComponentsForDesertDetail(mailID id: String) -> URLComponents {
        
        var components = URLComponents()
        
        components.scheme = MEAL_API.schema
        components.host = MEAL_API.host
        components.path = MEAL_API.desertDetailPath
        components.queryItems = [URLQueryItem(name: "i", value: id)]
        
        return components
        
    }
    
    
    
    
}

// MARK: - Endpoint Comps
struct MEAL_API {
    static let schema = "https"
    static let host = "www.themealdb.com"
    static let version = "v1/1"
    static let basepath = "api/json/\(version)"
    
    static let desertPath = "/\(basepath)/filter.php"
    static let desertDetailPath = "/\(basepath)/lookup.php"
    
    
}
