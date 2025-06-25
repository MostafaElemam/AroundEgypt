//
//  ExperienceService.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import Foundation

class ExperienceService {
    
    let networkService: NetworkService
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getExperience(for id: Int) async -> Experience? {
        let url = K.experiencesURL + "/\(id)"
        let response: ExperienceResponse? = try? await networkService.get(from: url)
        return response?.data
    }
    func likeExperience(id: Int) async -> Bool {
        let url = K.experiencesURL + "/\(id)/like"
        let success = try? await networkService.post(to: url)
        return success ?? false
    }
}



