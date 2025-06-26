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
    let favouriteManager: FavouriteService
    let coreDataService: CoreDataService
    
    init(id: String,
         service: ExperienceService = ExperienceService(),
         favouriteManager: FavouriteService = FavouriteManager.shared,
         coreDataService: CoreDataService = CoreDataManager.shared) {
        self.id = id
        self.service = service
        self.favouriteManager = favouriteManager
        self.coreDataService = coreDataService
        
        Task {
            await getDetails()
        }
    }
    
    // MARK: - Funcs
    func getDetails() async {
        //Load offline first
        await MainActor.run {
            self.experience = coreDataService.getSavedExperience(by: id)
        }
        guard let exp = await service.getExperience(for: id) else { return }
        await MainActor.run {
            self.experience = exp
        }
    }
    func likeExperience() async -> Bool {
        guard let id = experience?.id else { return false }
        
        let likesCount = await service.likeExperience(id: id)
        guard let likesCount else {
            await MainActor.run {
                self.experience?.isLiked = false
            }
            return false
        }
        await MainActor.run {
            favouriteManager.addToLikedExperiences(id: id)
            self.experience?.likesNumber = likesCount
            coreDataService.updateExperience(experience, isRecent: nil)
        }
        return true
        
    }
}
