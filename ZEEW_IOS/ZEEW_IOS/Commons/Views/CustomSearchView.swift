//
//  CustomSearchView.swift
//  ZEEW_IOS
//
//  Created by Usef on 07/05/2025.
//

import SwiftUI

struct CustomSearchView: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
                .padding(.leading)
            TextField("Search", text: $searchText)
                .padding(.vertical, 20)
                .foregroundStyle(.white)

                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.green, lineWidth: 1)
                )
            Button(action: {
                // Action for microphone
            }) {
                Image(systemName: "mic.fill")
                    .foregroundColor(.white)
            }
            .padding(.trailing)
        }
        .background(Color.green)
        .cornerRadius(40)
        .padding(.horizontal)
        .padding(.bottom)
    }
}
#Preview {
    CustomSearchView(searchText: .constant(""))
}
