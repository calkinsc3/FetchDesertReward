//
//  FetchDesertRewardTests.swift
//  FetchDesertRewardTests
//
//  Created by Bill Calkins on 6/17/22.
//

import XCTest
@testable import FetchDesertReward

class FetchDesertRewardTests: XCTestCase {
    
    let jsonDecoder = JSONDecoder()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDesertModel() throws {
        
        // Test the desert model
        guard let desertModelData = getMockData(forResource: "Deserts") else {
            XCTFail("Count not find Deserts.json in the file bundle")
            return
        }
        //attempt to decode the data buffer into structured data
        do {
            let desertModel = try jsonDecoder.decode(Deserts.self, from: desertModelData)
            XCTAssertTrue(desertModel.meals.count == 64, "DesertModel meals count should be 64")
            
        } catch {
            XCTFail("Failed to decode Desert data: \(error)")
        }
        
    }
    
    func testMealDetailModel() throws {
        
        // Test the meal detail data structure
        guard let mealDetails = getMockData(forResource: "Meals") else {
            XCTFail("Cannot find Meals.json in the file bundle.")
            return
        }
        
        do {
            let mealModel = try jsonDecoder.decode(MealDetail.self, from: mealDetails)
            if let ingredientsCount = mealModel.meals.first?.count {
                XCTAssertTrue(ingredientsCount == 53, "The ingredients count should be 53")
            }
        } catch {
            XCTFail("Failed to decode Meal Detail data: \(error)")
        }
        
        
    }
    
    // MARK: - Helper Functions
    private func createPath(forJSONFile: String) -> URL {
        
        
        let jsonURL = URL(
            fileURLWithPath: forJSONFile,
            relativeTo: FileManager.documentDirectoryURL?.appendingPathComponent("\(forJSONFile)")
        ).appendingPathExtension("json")
        
        print("json path for \(forJSONFile) = \(jsonURL.absoluteString)")
        
        return jsonURL
    }
    
    private func getMockData(forResource: String) -> Data? {
        
        //This is included in they myamfam target becasue it will be used the app.
        let currentBundle = Bundle(for: type(of: self))
        if let pathForRecommendationMock = currentBundle.url(forResource: forResource, withExtension: "json") {
            do {
                return try Data(contentsOf: pathForRecommendationMock)
            } catch {
                XCTFail("Unable to convert \(pathForRecommendationMock) to Data.")
                return nil
            }
        } else {
            XCTFail("Unable to load \(forResource).json.")
            return nil
        }
        
    }
    
    
}

// MARK: - Helper Ex
extension FileManager {
    static var documentDirectoryURL: URL? {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            return nil //if there is an error return nil
        }
    }
}

