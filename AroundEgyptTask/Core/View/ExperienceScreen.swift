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
    let didLike: (_ id: String) -> Void
    
    init(id: String, didLike: @escaping (_ id: String) -> Void) {
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
    }
}

// MARK: - Components
extension ExperienceScreen {
    private var coverView: some View {
        ZStack(alignment: .center) {
            KFImage(URL(string: viewModel.experience?.coverPhoto ?? ""))
                .resizable()
                .placeholder {
                    ProgressView().tint(.customOrange)
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: 290)
            
            
            
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
        .overlay(alignment: .bottom) {
            //View Counts
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
        
        
    }
    private var content: some View {
        VStack(spacing: 20) {
            //Title and Actions
            VStack(alignment: .leading) {
                HStack(spacing: 14) {
                    Text(viewModel.experience?.title ?? "\t")
                        .customFont(.bold, size: 16)
                    Spacer(minLength: 0)
                    Button {}
                    label: { Image(.share) }
                    
                    Button(action: likeExperience) {
                        Image(
                            viewModel.experience?.isLiked ?? false  ? .heartFilled : .heartEmpty
                        )
                    }
                    .disabled(viewModel.experience?.isLiked ?? false)
                    
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
                Text(viewModel.experience?.description ?? "\t")
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
            let isLiked = await viewModel.likeExperience()
            if isLiked {
                didLike(viewModel.id)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ExperienceScreen(id: Preview.dev.experience.id) { _ in }
}
