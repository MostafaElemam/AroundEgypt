//
//  ExperienceScreen.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import SwiftUI

struct ExperienceScreen: View {
    // MARK: - Properties
    
    
    // MARK: - View
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                coverView
                content
            }
        }
    }
}

// MARK: - Components
extension ExperienceScreen {
    private var coverView: some View {
        ZStack {
            Image(.chicken)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 290)
            
            //Explore Now Btn
            Button {
                
            } label: {
                Text("EXPLORE NOW")
                    .customFont(.bold, size: 14)
                    .foregroundStyle(.customOrange)
                    .padding()
                    .background(
                        Color.white
                            .cornerRadius(7)
                    )
                
            }
        }
        .padding(.bottom, 10)
        .overlay(alignment: .bottom) {
            //Visit Counts
            HStack {
                Label("156", systemImage: "eye.fill")
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
                    Text("Abu Simple")
                        .customFont(.bold, size: 16)
                    Spacer(minLength: 0)
                    Button {}
                    label: { Image(.share) }
                    
                    Button {}
                    label: { Image(.heartEmpty) }
                    
                    Text("45")
                        .customFont(.medium, size: 14)
                    
                }
                .foregroundStyle(.black)
                Text("Aswan, Egypt")
                    .customFont(.medium, size: 16)
                    .foregroundStyle(.customDarkGray)
                
            }
            .lineLimit(2)
            
            Divider()
            //Description
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Description")
                    .customFont(.bold, size: 22)
                Text("The Abu Simbel temples are two massive rock temples at Abu Simbel, a village in Nubia, southern Egypt, near the border with Sudan. They are situated on the western bank of Lake Nasser, about 230 km southwest of Aswan (about 300 km by road). The twin temples were originally carved out of the mountainside in the 13th century BC, during the 19th dynasty reign of the Pharaoh Ramesses II. They serve as a lasting monument to the king and his queen Nefertari, and commemorate his victory at the Battle of Kadesh. Their huge external rock relief figures have become iconic.")
                    .customFont(.medium, size: 14)
            }
            .foregroundStyle(.black)
            
        }
        .padding()
    }
}

// MARK: - Functions
extension ExperienceScreen {
    
}

// MARK: - Preview

#Preview {
    ExperienceScreen()
}
