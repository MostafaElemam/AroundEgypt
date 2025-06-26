//
//  ExperiencesService.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import Foundation

class ExperiencesService {
    
    let networkService: NetworkServiceProtocol
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getExperiences(url: String) async throws -> [Experience] {
        do {
            let response: ExperiencesResponse = try await networkService.get(from: url)
            return response.data
            
        } catch let error as NetworkError {
            await Helpers.showBanner(error.errorDescription)
            throw error
        }
        catch {
            throw error
        }
    }
}
