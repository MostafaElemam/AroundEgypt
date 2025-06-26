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
        }
        Task {
            await getRecentExperiences()
        }
    }
    
    // MARK: - Funcs
    
    func getRecommendedExperiences() async  {
        let url = K.experiencesURL + "?filter[recommended]=true"
        let exps = await service.getExperiences(url: url)
        guard let exps else { return }
        await MainActor.run {
            self.recommendedExperiences = exps
        }
    }
    func getRecentExperiences() async  {
        let url = K.experiencesURL
        let exps = await service.getExperiences(url: url)
        guard let exps else { return }
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
            let exps = await service.getExperiences(url: url)
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
