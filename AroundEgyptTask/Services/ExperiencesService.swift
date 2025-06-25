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
    
    func getRecommendedExperiences() async -> [Experience]? {
        let url = K.experiencesURL + "?filter[recommended]=true"
        let response: ExperiencesResponse? = try? await networkService.get(from: url)
        return response?.data
    }
    func getRecentExperiences() async -> [Experience]? {
        let url = K.experiencesURL
        let response: ExperiencesResponse? = try? await networkService.get(from: url)
        return response?.data
    }
    
    func searchExperiences(q: String) async -> [Experience]? {
        let url = K.experiencesURL + "?filter[title]=\(q)"
        let response: ExperiencesResponse? = try? await networkService.get(from: url)
        return response?.data
    }
}
