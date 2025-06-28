//
//  ExperiencesList.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 28/06/2025.
//

import SwiftUI

struct ExperiencesList: View {
    // MARK: - Properties
    let headerTitle: String?
    let data: [Experience]?
    var shouldShimmer: Bool = false
    let axis: Axis.Set
    @Binding var selectedExperience: Experience?
    
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            if let headerTitle {
                Text(headerTitle)
                    .customFont(.bold, size: 22)
            }
            
            if axis == .horizontal {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        experienceItems
                    }
                }
            } else {
                VStack(spacing: 20) {
                    experienceItems
                }
            }
            
        }
    }
}
// MARK: - Components
extension ExperiencesList {
    private var experienceItems: some View {
        ForEach(data?.indices ?? 0..<5, id: \.self) { index in
            ExperienceView(experience: data?[index], shimmerLabels: shouldShimmer)
                .frame(width: axis == .horizontal ? 340 : nil)
                .contentShape(.rect)
                .onTapGesture {
                    if shouldShimmer { return }
                    selectedExperience = data?[index]
                }
        }
    }
}
// MARK: - Preview

#Preview {
//    ExperiencesList()
}
