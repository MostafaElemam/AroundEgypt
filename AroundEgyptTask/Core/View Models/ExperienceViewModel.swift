//
//  ExperienceViewModel.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import Foundation

class ExperienceViewModel: ObservableObject {
    @Published var experience: Experience?
    let id: String
    let service: ExperienceService
    
    init(id: String, service: ExperienceService = ExperienceService()) {
        self.id = id
        self.service = service
        Task {
            await getDetails()
        }
    }
    
    // MARK: - Funcs
    func getDetails() async {
        //Load offline first
        await MainActor.run {
            self.experience = CoreDataManager.shared.getSavedExperience(by: id)
        }
        guard let exp = await service.getExperience(for: id) else { return }
        await MainActor.run {
            self.experience = exp
        }
    }
    func likeExperience() async -> Bool {
        guard let id = experience?.id else { return false }
        
        let isLiked = await service.likeExperience(id: id)
        await MainActor.run {
            if isLiked {
                FavouriteManager.shared.addToLikedExperiences(id: id)
                self.experience?.likesNumber += 1
                CoreDataManager.shared.updateExperience(experience)
            } else {
                experience?.isLiked = false
            }
        }
        return isLiked
    }
}
