//
//  ExperienceService.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import Foundation

class ExperienceService {
    
    private let networkService: NetworkService
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func getExperience(for id: String) async -> Experience? {
        let url = K.experiencesURL + "/\(id)"
        do {
            let response: ExperienceResponse = try await networkService.get(from: url)
            return response.data
            
        } catch let error as NetworkError {
            await Helpers.showBanner(error.errorDescription)
        }
        catch {}
        return nil
    }
    
    func likeExperience(id: String) async -> Bool {
        let url = K.experiencesURL + "/\(id)/like"
        do {
            let success = try await networkService.post(to: url)
            return success
            
        } catch let error as NetworkError {
            await Helpers.showBanner(error.errorDescription)
        }
        catch {}
        return false
    }
}



