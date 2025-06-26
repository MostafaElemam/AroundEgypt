//
//  NetworkManager.swift
//  MovieExplorer
//
//  Created by Mostafa Elemam on 16/06/2025.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func get<T: Codable>(from endPoint: String) async throws -> T
    func post(to endPoint: String) async throws -> Bool
}

class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Get Data
    func get<T: Codable>(from endPoint: String) async throws -> T  {
        guard let _ = URL(string: endPoint) else { throw NetworkError.invalidURL }
        let request = AF.request(endPoint, method: .get, headers: K.headers)
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
    
    // MARK: - Post Data
    func post(to endPoint: String) async throws -> Bool {
        guard let _ = URL(string: endPoint) else { throw NetworkError.invalidURL }
        let request = AF.request(endPoint, method: .post, headers: K.headers)
        let response = await request.serializingData().response
        debugPrint(response)
        
        if let statusCode = response.response?.statusCode {
              guard (200...299).contains(statusCode) else {
                  throw NetworkError.serverError(statusCode: statusCode)
              }
            return true
          } else {
              throw NetworkError.networkFailure(error: response.error ?? AFError.explicitlyCancelled)
          }
    }
}

