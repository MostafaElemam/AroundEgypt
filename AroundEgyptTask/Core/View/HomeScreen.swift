//
//  HomeScreen.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import SwiftUI

struct HomeScreen: View {
    
    // MARK: - Properties
    @EnvironmentObject private var homeVM: HomeViewModel
    @State private var selectedExperience: Experience?
    
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 0) {
            topBar
            
            ScrollView(showsIndicators: false) {
                if homeVM.filteredExperiences.isEmpty {
                    VStack(alignment: .leading, spacing: 32) {
                        header
                        recommendedExperiences
                        experienceList(data: homeVM.recentExperiences)
                    }
                } else {
                    experienceList(data: homeVM.filteredExperiences, forRecentExps: false)
                }
                
            }
            .safeAreaPadding(20)
            .refreshable {
                Task { await homeVM.getRecentExperiences() }
                Task { await homeVM.getRecommendedExperiences() }
            }
        }
        .onAppear(perform: refreshData)
        .toolbar(.hidden)
        .sheet(item: $selectedExperience) {
            ExperienceScreen(id: $0.id) { likedExperienceID in
                homeVM.updateLikedExperiences(id: likedExperienceID)
            }
        }
    }
}

// MARK: - Components
extension HomeScreen {
    private var header: some View {
        VStack(alignment: .leading) {
            Text("Welcome!")
                .customFont(.boldRounded, size: 22)
            Text("Now you can explore any experience in 360 degrees and get all the details about it all in one place.")
                .customFont(.medium, size: 14)
        }
        .foregroundStyle(.black)
    }
    
    private var recommendedExperiences: some View {
        VStack(alignment: .leading) {
            Text("Recommended Experiences")
                .customFont(.bold, size: 22)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(homeVM.recommendedExperiences, id: \.id) { exp in
                        ExperienceView(experience: exp, isLoading: homeVM.loadingRecommendedExp)
                            .frame(width: 340)
                            .onTapGesture {
                                if homeVM.loadingRecommendedExp { return }
                                selectedExperience = exp
                            }
                    }
                }
            }
        }
    }
    
    private var topBar: some View {
        HStack(spacing: 12) {
            Image(systemName: "line.3.horizontal")
            CustomSearchBar(searchText: $homeVM.searchText) {
                homeVM.searchForExperiences()
            }
            Image(.filter)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
    }
}

// MARK: - Functions
extension HomeScreen {
    
    //For more recent and searched experiences
    func experienceList(data: [Experience], forRecentExps: Bool = true) -> some View {
        VStack(alignment: .leading) {
            if forRecentExps {
                Text("Most Recent")
                    .customFont(.bold, size: 22)
            }
            VStack(spacing: 20) {
                ForEach(data, id: \.id) { exp in
                    ExperienceView(experience: exp, isLoading: homeVM.loadingRecentExp)
                        .onTapGesture {
                            if forRecentExps,homeVM.loadingRecentExp { return }
                            selectedExperience = exp
                        }
                }
            }
        }
    }
    private func refreshData() {
        NetworkMonitor.shared.onReconnect =  {
            Helpers.showBanner(title: "", "📶 Network reconnected.", theme: .success)
            Task { await homeVM.getRecentExperiences() }
            Task { await homeVM.getRecommendedExperiences() }
        }
    }
}
// MARK: - Preview

#Preview {
    NavigationStack {
        HomeScreen()
            .environmentObject(HomeViewModel())
    }
}
