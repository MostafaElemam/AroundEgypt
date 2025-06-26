//
//  ExperiencesService.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import Foundation

class ExperiencesService {
    
    let networkService: NetworkService
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func getExperiences(url: String) async -> [Experience]? {
        do {
            let response: ExperiencesResponse = try await networkService.get(from: url)
            return response.data
            
        } catch let error as NetworkError {
            await Helpers.showBanner(error.errorDescription)
        }
        catch {}
        return nil
    }
}
