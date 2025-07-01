//
//  HomeViewModel.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var recommendedExperiences: [Experience]?
    @Published var recentExperiences: [Experience]?
    @Published var filteredExperiences: [Experience] = []
    @Published var searchText: String = ""
    @Published var loadingRecommendedExp = true
    @Published var loadingRecentExp = true
    
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
            let savedExps = coreDataService.getSavedExperiences(forRecent: false)
            recommendedExperiences = savedExps.isEmpty ? nil : savedExps
            loadingRecommendedExp = savedExps.isEmpty
        }
        
        let url = K.experiencesURL + "?filter[recommended]=true"
        let exps = try? await service.getExperiences(url: url)
        guard let exps else { return }
        
        for exp in exps {
            coreDataService.updateExperience(exp, isRecent: false)
        }
        await MainActor.run {
            self.loadingRecommendedExp = false
            self.recommendedExperiences = exps
        }
    }
    func getRecentExperiences() async  {
        //Load offline first
        await MainActor.run {
            let savedExps = coreDataService.getSavedExperiences(forRecent: true)
            recentExperiences = savedExps.isEmpty ? nil : savedExps
            loadingRecentExp = savedExps.isEmpty
        }
        
        let url = K.experiencesURL
        let exps = try? await service.getExperiences(url: url)
        guard let exps else { return }
        for exp in exps {
            coreDataService.updateExperience(exp, isRecent: true)
        }
        
        await MainActor.run {
            self.loadingRecentExp = false
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
    
    func updateLikedExperiences(id: String, count: Int) {
        if let index = recentExperiences?.firstIndex(where: { $0.id == id }) {
            recentExperiences?[index].likesNumber = count
            recentExperiences?[index].isLiked = true
        }
        if let index = recommendedExperiences?.firstIndex(where: { $0.id == id }) {
            recommendedExperiences?[index].likesNumber = count
            recommendedExperiences?[index].isLiked = true
        }
        if let index = filteredExperiences.firstIndex(where: { $0.id == id }) {
            filteredExperiences[index].likesNumber = count
            filteredExperiences[index].isLiked = true
        }
    }
    
}
