//
//  HomeViewModel.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var recommendedExperiences: [Experience] = []
    @Published var recentExperiences: [Experience] = []
    @Published var filteredExperiences: [Experience] = []
    @Published var searchText: String = ""
    
    let service: ExperiencesService
    let coreDataService: CoreDataService
    
    init(service: ExperiencesService = ExperiencesService(),
         coreDataService: CoreDataService = CoreDataManager.shared) {
        self.service = service
        self.coreDataService = coreDataService
        
        Task { await getRecommendedExperiences() }
        Task { await getRecentExperiences() }
    }
    
    // MARK: - Funcs
    
    func getRecommendedExperiences() async  {
        //Load offline first
        await MainActor.run {
            self.recommendedExperiences =  coreDataService.getSavedExperiences(forRecent: false)
        }
        
        let url = K.experiencesURL + "?filter[recommended]=true"
        let exps = try? await service.getExperiences(url: url)
        guard let exps else { return }
        for exp in exps {
            coreDataService.updateExperience(exp, isRecent: false)
        }
        await MainActor.run {
            self.recommendedExperiences = exps
        }
    }
    func getRecentExperiences() async  {
        //Load offline first
        await MainActor.run {
            self.recentExperiences = coreDataService.getSavedExperiences(forRecent: true)
        }
        
        let url = K.experiencesURL
        let exps = try? await service.getExperiences(url: url)
        guard let exps else { return }
        for exp in exps {
            coreDataService.updateExperience(exp, isRecent: true)
        }
        
        await MainActor.run {
            self.recentExperiences = exps
        }
    }
    
    func searchForExperiences() {
        guard !searchText.isEmpty else {
            filteredExperiences = []
            return
        }
        let url = K.experiencesURL + "?filter[title]=\(searchText)"
        Task {
            let exps = try? await service.getExperiences(url: url)
            guard let exps else { return }
            await MainActor.run {
                self.filteredExperiences = exps
            }
        }
    }
    
    func updateLikedExperiences(id: String) {
        if let index = recentExperiences.firstIndex(where: { $0.id == id }) {
            recentExperiences[index].likesNumber += 1
            recentExperiences[index].isLiked = true
        }
        if let index = recommendedExperiences.firstIndex(where: { $0.id == id }) {
            recommendedExperiences[index].likesNumber += 1
            recommendedExperiences[index].isLiked = true
        }
        if let index = filteredExperiences.firstIndex(where: { $0.id == id }) {
            filteredExperiences[index].likesNumber += 1
            filteredExperiences[index].isLiked = true
        }
    }
    
}
