//
//  ExperienceService.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import Foundation

class ExperienceService {
    
    private let networkService: NetworkServiceProtocol
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getExperience(for id: String) async -> Experience? {
        let url = K.experiencesURL + "/\(id)"
        do {
            let response: ExperienceResponse = try await networkService.request(url, method: .get)
            return response.data
            
        } catch let error as NetworkError {
            await Helpers.showBanner(error.errorDescription)
        }
        catch {}
        return nil
    }
    
    ///- Returns: the total number of likes for experiens
    func likeExperience(id: String) async -> Int? {
        let url = K.experiencesURL + "/\(id)/like"
        do {
            let response: UpdateExperienceResponse = try await networkService.request(url, method: .post)
            return response.data
            
        } catch let error as NetworkError {
            await Helpers.showBanner(error.errorDescription)
        }
        catch {}
        return nil
    }
}



