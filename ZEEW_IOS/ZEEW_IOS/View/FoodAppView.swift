//
//  FoodAppView.swift
//  ZEEW
//
//  Created by Usef on 07/05/2025.
//

import SwiftUI

struct FoodAppView: View {
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem { Label("Home", systemImage: "house") }
            
            CategoryView()
                .tabItem { Label("Categories", systemImage: "square.grid.3x3.middle.filled") }
            
            SearchPageView()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
            
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person") }
        }
    }
}

#Preview {
    FoodAppView()
}
