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
    
    init(service: ExperiencesService = ExperiencesService()) {
        self.service = service
        Task {
            await getRecommendedExperiences()
            await getRecentExperiences()
        }
    }
    
    // MARK: - Funcs
    
    func getRecommendedExperiences() async  {
        let exps = await service.getRecommendedExperiences()
        guard let exps else { return }
        await MainActor.run {
            self.recommendedExperiences = exps
        }
    }
    func getRecentExperiences() async  {
        let exps = await service.getRecentExperiences()
        guard let exps else { return }
        await MainActor.run {
            self.recentExperiences = exps
        }
    }
    
    func getFilteredExperiences() async {
        let exps = await service.searchExperiences(q: searchText)
        guard let exps else { return }
        await MainActor.run {
            self.filteredExperiences = exps
        }
    }
    
    
}
