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
    @State private var showExperienceDetails = false
    
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 0) {
            topBar
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 32) {
                    header
                    recommendedExperiences
                    mostRecentExperiences
                }
            }
            .safeAreaPadding(20)
        }
        .toolbar(.hidden)
        .sheet(isPresented: $showExperienceDetails, onDismiss: {
            print("Dismissed")
        }) { ExperienceScreen() }
        
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
                LazyHStack(spacing: 10) {
                    ForEach(homeVM.recommendedExperiences, id: \.id) { exp in
                        ExperienceView(experience: exp)
                            .frame(width: 340)
                            .onTapGesture {
                                showExperienceDetails = true
                            }
                    }
                }
            }
        }
    }
    
    private var mostRecentExperiences: some View {
        VStack(alignment: .leading) {
            Text("Most Recent")
                .customFont(.bold, size: 22)
            
            LazyVStack(spacing: 20) {
                ForEach(homeVM.recentExperiences, id: \.id) { exp in
                    ExperienceView(experience: exp)
                        .onTapGesture {
                            showExperienceDetails = true
                        }
                }
            }
        }
    }
    private var topBar: some View {
        HStack(spacing: 12) {
            Image(systemName: "line.3.horizontal")
            CustomSearchBar(searchText: $homeVM.searchText)
            Image(.filter)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
    }
}

// MARK: - Functions
extension HomeScreen {
    
}

// MARK: - Preview

#Preview {
    NavigationStack {
        HomeScreen()
    }
}
