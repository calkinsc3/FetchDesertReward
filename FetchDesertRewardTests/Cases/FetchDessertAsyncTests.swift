//
//  FetchDessertAsyncTests.swift
//  FetchDesertRewardTests
//
//  Created by Bill Calkins on 7/7/22.
//

import XCTest
@testable import FetchDesertReward

final class FetchDessertAsyncTests: XCTestCase {
    

    func testFetchDesserts() async throws {
        
        let dessertFetcher = DessertFetcher()
        
        let testConfiguration = URLSessionConfiguration.default
        testConfiguration.protocolClasses = [TestURLProtocol.self]
        
        dessertFetcher.session = URLSession(configuration: testConfiguration)
        
        //will return data from mock
        let desserts = try await dessertFetcher.fetchDeserts()
        
        XCTAssertEqual(desserts.meals.count, 64)
        
        let request = try XCTUnwrap(TestURLProtocol.lastRequest)
        XCTAssertEqual(request.url?.absoluteString, "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert")
        
        
    }
    
    func testFetchDessertDetails() async throws {
        
        let dessertFetcher = DessertFetcher()
        
        let testConfiguration = URLSessionConfiguration.default
        testConfiguration.protocolClasses = [TestURLProtocol.self] //FIXME: need instance with correct testType
        
        dessertFetcher.session = URLSession(configuration: testConfiguration)
        
        //will return data from mock
        let dessert = try await dessertFetcher.fetchDesertDetails(withMealId: "53049")
        
        XCTAssertEqual(dessert.meals.first?["idMeal"], "53049")
        XCTAssertEqual(dessert.meals.first?["strMeal"], "Apam balik")
        
        let request = try XCTUnwrap(TestURLProtocol.lastRequest)
        XCTAssertEqual(request.url?.absoluteString, "https://www.themealdb.com/api/json/v1/1/lookup.php?i=53049")
        XCTAssertEqual(request.httpMethod, "GET")
        
    }
    
    func testFetchDessertImage() throws {
        
        
    }

    

}
