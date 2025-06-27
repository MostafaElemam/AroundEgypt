//
//  ExperienceView.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import SwiftUI
import Kingfisher

struct ExperienceView: View {
    let experience: Experience
    let isLoading: Bool
    
    // MARK: - View
    var body: some View {
        
            VStack(alignment: .leading, spacing: 14) {
                ZStack(alignment: .top) {
                    mainImage
                    recommendedLabelAndInfo
                }
                //360 Label
                .overlay(alignment: .center) {
                    Image(.image360)
                }
                .overlay(alignment: .bottom) {
                    viewsCounts
                }
                .foregroundColor(.white)
                titleAndLikes
            }
    }
}

// MARK: - Components
extension ExperienceView {
    
    private var mainImage: some View {
        KFImage(URL(string: experience.coverPhoto))
            .resizable()
            .placeholder {
                Image(.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 154)
            }
            .aspectRatio(contentMode: .fill)
            .frame(height: 154)
            .clipShape(.rect(cornerRadius: 7))
    }
    private var recommendedLabelAndInfo: some View {
        HStack {
            if experience.recommended == 1 {
                HStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.customOrange)
                    
                    Text("RECOMMENDED")
                        .customFont(.bold, size: 10)
                        
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    Color.black.opacity(0.5)
                        .clipShape(.capsule)
                )
            }
            Spacer()
            Image(systemName: "info.circle")
                .resizable()
                .frame(width: 20, height: 20)
        }
        .padding(10)
    }
    private var viewsCounts: some View {
        HStack {
            Label("\(experience.viewsNumber)", systemImage: "eye.fill")
                .customFont(.medium, size: 14)
                .foregroundColor(.white)
            
            Spacer()
            Image(.multiplePictures)
        }
        .padding(10)
    }
    
    private var titleAndLikes: some View {
        HStack(spacing: 8) {
            Text(experience.title)
                .customFont(.bold, size: 14)
            Spacer()
            Text(experience.likesNumber.description)
                .customFont(.medium, size: 14)
            Image(.heartFilled)
        }
        .redacted(isLoading)
        .foregroundStyle(.black)
    }
    
}

// MARK: - Preview

#Preview {
    ExperienceView(experience: Preview.dev.experience, isLoading: true)
        .padding(.horizontal, 20)
}
