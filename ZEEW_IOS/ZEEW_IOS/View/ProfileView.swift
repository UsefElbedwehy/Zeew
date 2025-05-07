//
//  ProfileView.swift
//  ZEEW_IOS
//
//  Created by Usef on 07/05/2025.
//

import SwiftUI

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        
        ZStack {
            VStack {
                UnevenRoundedRectangle(
                    cornerRadii: RectangleCornerRadii(
                        topLeading: 0,
                        bottomLeading: 30,
                        bottomTrailing: 30,
                        topTrailing: 0
                    )
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [.clear, .green.opacity(0.6)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: 100)
                Spacer()
                UnevenRoundedRectangle(
                    cornerRadii: RectangleCornerRadii(
                        topLeading: 30,
                        bottomLeading: 0,
                        bottomTrailing: 0,
                        topTrailing: 30
                    )
                )
                .ignoresSafeArea()
                .foregroundStyle(
                    LinearGradient(
                        colors: [.green.opacity(0.6),.clear, ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .padding(.top)
//                .frame(height: 100)
            }
            
            VStack {
                Spacer()
                    .frame(height: 50)
                ZStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundStyle(.green.opacity(0.2))
                        .frame(width: 190,height: 190)
                        .background(.white)
                        .clipShape(Circle())
                    
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundStyle(.green)
                        .frame(width: 160,height: 160)
                        .background(.white)
                        .clipShape(Circle())
                }
                
                Spacer()
            }
            
        }
    }
}


#Preview {
    ProfileView()
}
