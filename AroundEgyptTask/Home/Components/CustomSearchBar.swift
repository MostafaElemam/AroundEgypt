//
//  CustomSearchBar.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 14, height: 14)
                .foregroundColor(
                    searchText.isEmpty ? .gray : .black
                    )

            TextField("Try “Luxor”", text: $searchText)
                .foregroundColor(.black)
                .autocapitalization(.none)
                .keyboardType(.asciiCapable) // it make sure it hides the word suggestion
                .disableAutocorrection(true)
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 14, height: 14)
                        .padding()
                        .offset(x: 12)
                        .foregroundStyle(.black)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .background(Color(.systemGray6))
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                }
        }
        .font(.headline)
        .tint(.black)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

// MARK: - Preview

#Preview {
    CustomSearchBar(searchText: .constant(""))
        .padding(.horizontal)
}
