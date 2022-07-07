//
//  TestURLProtocol.swift
//  FetchDesertRewardTests
//
//  Created by Bill Calkins on 7/7/22.
//

import Foundation
@testable import FetchDesertReward

///Used to intercept and mock async network calls
class TestURLProtocol: URLProtocol {
    
    static var lastRequest: URLRequest?
    
    // MARK: URLProtocol
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    //mock the start of loading
    override func startLoading() {
        
        guard let client = client,
              let url = request.url,
              let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil),
              let desertModelData = getMockData(forResource: "Desserts")  else {
            
            fatalError("Client or URL is missing.")
        }
        
        //load the client - mock behavior
        client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client.urlProtocol(self, didLoad: desertModelData) //Load the mock into the request
        client.urlProtocolDidFinishLoading(self)

        var request = request
        request.httpBody = desertModelData
        Self.lastRequest = request
        
    }
    
    override func stopLoading() {
        
    }
    
    // MARK: - Helper Functions
    private func getMockData(forResource: String) -> Data? {
        
        //This is included in they myamfam target becasue it will be used the app.
        let currentBundle = Bundle(for: type(of: self))
        if let pathForRecommendationMock = currentBundle.url(forResource: forResource, withExtension: "json") {
            do {
                return try Data(contentsOf: pathForRecommendationMock)
            } catch {
                Log.networkLogger.info("Unable to convert \(pathForRecommendationMock) to Data.")
                //XCTFail("Unable to convert \(pathForRecommendationMock) to Data.")
                return nil
            }
        } else {
            Log.networkLogger.info("Unable to load \(forResource).json.")
            //XCTFail("Unable to load \(forResource).json.")
            return nil
        }
        
    }
    
}
