//
//  SearchPageView.swift
//  ZEEW_IOS
//
//  Created by Usef on 07/05/2025.
//

import SwiftUI

struct SearchPageView: View {
    @State var searchText: String = ""
    var body: some View {
        ZStack {
            AppBackGround()
            
            VStack {
                HeaderView()
                CustomSearchView(searchText: $searchText)
                
                
                HStack {
                    Text("Suggestion")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .padding(.horizontal)
                
                
                let columns = [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        FoodItemView(name: "Noodles", price: 140, imageName: "b1", discount: nil)
                        FoodItemView(name: "Pasta Brunch", price: 178, imageName: "pasta1", discount: "10% OFF")
                        FoodItemView(name: "Pizza", price: 250, imageName: "pasta2", discount: nil)
                        FoodItemView(name: "Custard", price: 200, imageName: "b2", discount: nil)
                        FoodItemView(name: "Apple Pie", price: 350, imageName: "drink", discount: "15% OFF")
                        FoodItemView(name: "Pastries", price: 300, imageName: "pizza", discount: nil)
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    SearchPageView()
}

struct HeaderView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("ZEEW")
                .foregroundStyle(.green)
                .font(.title)
                .padding(.trailing,50)
            
            Image(systemName: "text.justify")
                .frame(width: 40, height: 40)
            Image(systemName: "cart")
                .frame(width: 40, height: 40)
            
        }
        .frame(height: 40)
        .padding(.horizontal)
    }
}
