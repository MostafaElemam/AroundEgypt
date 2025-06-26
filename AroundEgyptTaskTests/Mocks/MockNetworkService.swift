//
//  MockNetworkService.swift
//  AroundEgyptTaskTests
//
//  Created by Mostafa Elemam on 26/06/2025.
//

import Foundation
@testable import AroundEgyptTask

class MockNetworkService: NetworkServiceProtocol {
    var shouldReturnError = false
    var mockData: [Experience] = []
    var mockExperience: Experience?
    var mockLikeSuccess = true
    var expectedError: NetworkError = .noData

    func get<T: Codable>(from endPoint: String) async throws -> T {
        if shouldReturnError {
            throw NetworkError.noData
        }
        // Handle response for [Experience]
        if T.self == ExperiencesResponse.self {
            let response = ExperiencesResponse(data: mockData)
            return response as! T
        }
        
        // Handle response for a single Experience
        if T.self == ExperienceResponse.self {
            guard let exp = mockExperience else {
                throw NetworkError.noData
            }
            let response = ExperienceResponse(data: exp)
            return response as! T
        }
        
        throw NetworkError.decodingError
    }
    
    func post(to endPoint: String) async throws -> Bool {
        if shouldReturnError {
            throw expectedError
        }
        return mockLikeSuccess
    }
    
    
}
