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
        
        var dessertFetcher = DessertFetcher()
        
        let testConfiguration = URLSessionConfiguration.default
        testConfiguration.protocolClasses = [TestURLProtocol.self]
        
        dessertFetcher.session = URLSession(configuration: testConfiguration)
        
        //will return data from mock
        let desserts = try await dessertFetcher.fetchDeserts()
        
        XCTAssertEqual(desserts.meals.count, 64)
        
        let request = try XCTUnwrap(TestURLProtocol.lastRequest)
        XCTAssertEqual(request.url?.absoluteString, "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert")
        
        
        
        
    }
    
    func testFetchDessertDetails() throws {
        
    }
    
    func testFetchDessertImage() throws {
        
        
    }

    

}
