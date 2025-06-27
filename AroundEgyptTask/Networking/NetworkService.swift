//
//  NetworkManager.swift
//  MovieExplorer
//
//  Created by Mostafa Elemam on 16/06/2025.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func request<T: Codable>(_ endPoint: String, method: HTTPMethod) async throws -> T
}

class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Get Data
    func request<T: Codable>(_ endPoint: String, method: HTTPMethod) async throws -> T  {
        
        guard NetworkMonitor.shared.isConnected else {
            throw NetworkError.noConnection
        }

        guard let _ = URL(string: endPoint) else {
            throw NetworkError.invalidURL
        }

        let request = AF.request(endPoint, method: method, headers: K.headers)
        let response = await request.serializingDecodable(T.self).response
        debugPrint(response)

        switch response.result {
            case .success(let data):
                return data

            case .failure(let error):
                if let statusCode = response.response?.statusCode {
                    throw NetworkError.serverError(statusCode: statusCode)
                } else {
                    throw NetworkError.networkFailure(error: error)
                }
        }
    }
}

