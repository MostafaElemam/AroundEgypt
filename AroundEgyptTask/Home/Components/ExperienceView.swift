//
//  ExperienceView.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import SwiftUI

struct ExperienceView: View {
    
    
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
                    visitCounts
                }
                .foregroundColor(.white)
                titleAndLikes
            }
    }
}

// MARK: - Components
extension ExperienceView {
    
    private var mainImage: some View {
        Image(.chicken)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 154)
            .clipShape(.rect(cornerRadius: 7))
    }
    private var recommendedLabelAndInfo: some View {
        HStack {
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
            Spacer()
            Image(systemName: "info.circle")
                .resizable()
                .frame(width: 20, height: 20)
        }
        .padding(10)
    }
    private var visitCounts: some View {
        HStack {
            Label("156", systemImage: "eye.fill")
                .customFont(.medium, size: 14)
                .foregroundColor(.white)
            
            Spacer()
            Image(.multiplePictures)
        }
        .padding(10)
    }
    
    private var titleAndLikes: some View {
        HStack(spacing: 8) {
            Text("Nubian House")
                .customFont(.bold, size: 14)
            Spacer()
            Text("356")
                .customFont(.medium, size: 14)
            Image(.heartFilled)
        }
    }
    
}

// MARK: - Preview

#Preview {
    ExperienceView()
        .padding(.horizontal, 20)
}
