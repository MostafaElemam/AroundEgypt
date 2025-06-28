//
//  HomeScreen.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import SwiftUI

struct HomeScreen: View {
    
    // MARK: - Properties
    @StateObject private var homeVM = HomeViewModel()
    @State private var selectedExperience: Experience?
    
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 0) {
            topBar
            
            Group {
                if homeVM.filteredExperiences.isEmpty {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 32) {
                            header
                            recommendedExperiences
                            recentExperiences
                        }
                    }
                    .refreshable { refreshExperiences() }
                    
                } else {
                    ScrollView(showsIndicators: false) {
                        filteredExperiences
                    }
                }
            }
            .safeAreaPadding(20)
        }
        .onAppear {
            NetworkMonitor.shared.onReconnect =  {
                Helpers.showBanner(title: "", "📶 Network reconnected.", theme: .success)
                refreshExperiences()
            }
        }
        .sheet(item: $selectedExperience) {
            ExperienceScreen(id: $0.id) { likedExperienceID, newCount in
                homeVM.updateLikedExperiences(id: likedExperienceID, count: newCount)
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
        ExperiencesList(headerTitle: "Recommended Experiences",
                        data: homeVM.recommendedExperiences,
                        shouldShimmer: homeVM.loadingRecommendedExp,
                        axis: .horizontal,
                        selectedExperience: $selectedExperience)
    }
    
    private var recentExperiences: some View {
        ExperiencesList(headerTitle: "Most Recent",
                        data: homeVM.recentExperiences,
                        shouldShimmer: homeVM.loadingRecentExp,
                        axis: .vertical,
                        selectedExperience: $selectedExperience)
    }
    
    private var filteredExperiences: some View {
        ExperiencesList(headerTitle: nil,
                        data: homeVM.filteredExperiences,
                        axis: .vertical,
                        selectedExperience: $selectedExperience)
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
    
    private func refreshExperiences() {
        Task { await homeVM.getRecentExperiences() }
        Task { await homeVM.getRecommendedExperiences() }
    }
}
// MARK: - Preview

#Preview {
    HomeScreen()
}
