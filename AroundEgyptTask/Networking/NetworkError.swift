//
//  NetworkError.swift
//  MovieExplorer
//
//  Created by Mostafa Elemam on 18/06/2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case networkFailure(error: Error)
    case serverError(statusCode: Int)
}

extension NetworkError {
    var errorDescription: String {
        switch self {
            case .invalidURL:
                return "The URL is invalid."
            case .noData: 
                return "No data received from the server."
            case .decodingError: 
                return "Failed to decode the response."
            case .serverError(let statusCode):
                switch statusCode {
                    case 401:
                        return "Unauthenticated. Please log in first."
                    case 404:
                        return "The movie id is invalid or not found."
                    case 502:
                        return "Couldn't connect to the backend server."
                    default:
                        return "Something went wrong"
                }
                
            case .networkFailure(let error):
                return error.localizedDescription.removedSemiColon
        }
    }
}
