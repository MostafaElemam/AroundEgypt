//
//  ExperienceScreen.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import SwiftUI
import Kingfisher

struct ExperienceScreen: View {
    // MARK: - Properties
    @StateObject private var viewModel: ExperienceViewModel
    let didLike: (_ id: String, _ newCount: Int) -> Void
    
    init(id: String, didLike: @escaping (_ id: String, _ newCount: Int) -> Void) {
        _viewModel = .init(wrappedValue: ExperienceViewModel(id: id))
        self.didLike = didLike
    }
    
    // MARK: - View
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                coverView
                content
            }
        }
        .onAppear(perform: refreshData)
    }
}

// MARK: - Components
extension ExperienceScreen {
    private var coverView: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .center) {
                KFImage(URL(string: viewModel.experience?.coverPhoto ?? ""))
                    .resizable()
                    .placeholder {
                        ProgressView().tint(.customOrange)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 290)
                    .scaledToFill()
                
                //Explore Now Btn
                Button {}
                label: {
                    Text("EXPLORE NOW")
                        .customFont(.bold, size: 14)
                        .foregroundStyle(.customOrange)
                        .padding()
                        .background(
                            Color.white.cornerRadius(7)
                        )
                }
            }
            //Views count
            viewsCount
        }
    }
    private var viewsCount: some View {
        HStack {
            Label(viewModel.experience?.viewsNumber.description ?? "\t", systemImage: "eye.fill")
                .customFont(.medium, size: 14)
                .foregroundColor(.white)
            
            Spacer()
            Image(.multiplePictures)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(
            LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
        )
    }
    private var content: some View {
        VStack(alignment: .leading, spacing: 20) {
            //Title and Actions
            VStack(alignment: .leading) {
                HStack(spacing: 14) {
                    Text(viewModel.experience?.title ?? "\t")
                        .customFont(.bold, size: 16)
                    Spacer(minLength: 0)
                    
                    //Share Link
                    ShareLink(item: URL(string: "https://aroundegypt.34ml.com")!) {
                        Image(.share)
                    }
                    
                    //Like Button
                    Button(action: likeExperience) {
                        Image(
                            viewModel.experience?.isLiked ?? false  ? .heartFilled : .heartEmpty
                        )
                    }
                    .disabled(viewModel.experience?.isLiked ?? false)
                    
                    //Likes Count
                    Text(viewModel.experience?.likesNumber.description ?? "\t")
                        .customFont(.medium, size: 14)
                    
                }
                .foregroundStyle(.black)
                Text("\(viewModel.experience?.city.name ?? ""), Egypt")
                    .customFont(.medium, size: 16)
                    .foregroundStyle(.customDarkGray)
                
            }
            .lineLimit(2)
            
            Divider()
            
            //Description
            VStack(alignment: .leading, spacing: 4) {
                Text("Description")
                    .customFont(.bold, size: 22)
                
                let description = viewModel.experience?.description ?? ""
                Text(description.isEmpty ? "Description is not available. 😔" : description)
                    .customFont(.medium, size: 14)
            }
            .foregroundStyle(.black)
            
        }
        .padding()
    }
}

// MARK: - Functions
extension ExperienceScreen {
    private func likeExperience() {
        viewModel.experience?.isLiked = true
        Task {
            let response = await viewModel.likeExperience()
            if response.success, let count = response.count {
                didLike(viewModel.id, count)
            }
        }
    }
    private func refreshData() {
        NetworkMonitor.shared.onReconnect =  {
            Helpers.showBanner(title: "", "📶 Network reconnected.", theme: .success)
            Task { await viewModel.getDetails() }
        }
    }
}

// MARK: - Preview

#Preview {
    ExperienceScreen(id: Preview.dev.experience.id) { _, _ in }
}
