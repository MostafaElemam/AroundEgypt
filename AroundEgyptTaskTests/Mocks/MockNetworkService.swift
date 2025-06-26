//
//  MockNetworkService.swift
//  AroundEgyptTaskTests
//
//  Created by Mostafa Elemam on 26/06/2025.
//

import Foundation
@testable import AroundEgyptTask
@testable import Alamofire


class MockNetworkService: NetworkServiceProtocol {
    
    var shouldReturnError = false
    var mockData: [Experience] = []
    var mockExperience: Experience?
    var mockLikeSuccess = true
    var expectedError: NetworkError = .noData

    func request<T: Codable>(_ endPoint: String, method: HTTPMethod) async throws -> T {
        if shouldReturnError {
            throw expectedError
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
        // Handle response for a Like Experience
        if T.self == UpdateExperienceResponse.self {
            guard let exp = mockExperience else {
                throw NetworkError.noData
            }
            let response = UpdateExperienceResponse(data: exp.likesNumber + 1)
            return response as! T
        }
        
        throw NetworkError.decodingError
    }
    
}
