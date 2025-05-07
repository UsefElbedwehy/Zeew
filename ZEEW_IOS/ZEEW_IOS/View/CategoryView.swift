//
//  CategoryView.swift
//  ZEEW_IOS
//
//  Created by Usef on 07/05/2025.
//

import SwiftUI

import SwiftUI

struct CategoryView: View {
    @State private var selectedCategory: String = "All"
    
    var body: some View {
        
        ZStack {
            AppBackGround()
            VStack {
                HeaderView()
                HStack {
                    Text("Categories")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    Spacer()
                }
                .padding(.horizontal)
                ScrollView {
                    VStack {
                        // Category Tabs
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                CategoryButton1(title: "All", isSelected: selectedCategory == "All") {
                                    selectedCategory = "All"
                                }
                                CategoryButton1(title: "Burger", isSelected: selectedCategory == "Burger") {
                                    selectedCategory = "Burger"
                                }
                                CategoryButton1(title: "Pizza", isSelected: selectedCategory == "Pizza") {
                                    selectedCategory = "Pizza"
                                }
                                CategoryButton1(title: "Rice", isSelected: selectedCategory == "Rice") {
                                    selectedCategory = "Rice"
                                }
                                CategoryButton1(title: "Pasta", isSelected: selectedCategory == "Pasta") {
                                    selectedCategory = "Pasta"
                                }
                                CategoryButton1(title: "Egyptian", isSelected: selectedCategory == "Egyptian") {
                                    selectedCategory = "Egyptian"
                                }
                            }
                            .padding([.leading, .top, .bottom])
                        }
                        HStack {
                            Text("Food Category")
                                .padding(.leading)
                                .font(.title)
                                .bold()
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                FoodItemView(name: "Noodles", price: 140, imageName: "pasta1", discount: nil)
                                FoodItemView(name: "Pasta Brunch", price: 178, imageName: "pasta2", discount: "10% OFF")
                                FoodItemView(name: "Pizza", price: 250, imageName: "pizza", discount: nil)
                                FoodItemView(name: "Custard", price: 200, imageName: "b1", discount: nil)
                                FoodItemView(name: "Apple Pie", price: 350, imageName: "b2", discount: "15% OFF")
                                FoodItemView(name: "Pastries", price: 300, imageName: "drink", discount: nil)
                            }
                            .padding(.leading)
                            .padding(.bottom)
                        }
                        HStack {
                            Text("Sweet Category")
                                .padding(.leading)
                                .font(.title)
                                .bold()
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                FoodItemView(name: "Noodles", price: 140, imageName: "dessert1", discount: nil)
                                FoodItemView(name: "Pasta Brunch", price: 178, imageName: "drink", discount: "10% OFF")
                                FoodItemView(name: "Pizza", price: 250, imageName: "dessert2", discount: nil)
                                FoodItemView(name: "Custard", price: 200, imageName: "drink", discount: nil)
                                FoodItemView(name: "Apple Pie", price: 350, imageName: "dessert1", discount: "15% OFF")
                                FoodItemView(name: "Pastries", price: 300, imageName: "dessert2", discount: nil)
                            }
                            .padding(.leading)
                            .padding(.bottom)
                        }
                    }
                }
                .navigationTitle("Categories")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            print("Cart tapped")
                        }) {
                            Image(systemName: "cart.fill")
                                .font(.title2)
                        }
                        
                        Button(action: {
                            print("Grid icon tapped")
                        }) {
                            Image(systemName: "square.grid.2x2")
                                .font(.title2)
                        }
                    }
                }
            }
        }
    }
}

struct CategoryButton1: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.bold)
                .padding(.horizontal,30)
                .padding(.vertical,10)
                .background(isSelected ? Color.green : Color.white)
                .cornerRadius(18)
                .foregroundColor(isSelected ? Color.white : Color.gray)
                .shadow(radius: 4)
        }
    }
}

struct FoodItemView: View {
    let name: String
    let price: Int
    let imageName: String // Add image name for the food item
    var discount: String? // Optional discount

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            // Image with discount badge
            ZStack(alignment: .topTrailing) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 170, height: 120)
                    .clipped()
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray5), lineWidth: 1)
                    )
                
                if let discount = discount {
                    Text(discount)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.green)
                        .cornerRadius(20)
                        .padding(8)
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                }
            }
            
            // Food name
            Text(name)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .lineLimit(1)
                .frame(width: 160)
                .padding(.horizontal, 8)
            
            // Price
            Text("₹ \(price)")
                .font(.system(size: 14))
                .foregroundColor(colorScheme == .dark ? .white : .gray)
                .padding(.horizontal, 8)

            // Add to cart button
            Button(action: {
                print("Added to cart: \(name)")
            }) {
                Text("Add to cart")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 120, height: 32)
                    .background(Color.green)
                    .cornerRadius(20)
            }
            .buttonStyle(ScaleButtonStyle())
        }
        .frame(width: 170)
        .padding(.bottom, 12)
        .background(colorScheme == .dark ? Color(.systemGray6) : Color.white)
        .cornerRadius(12)
        .shadow(
            color: colorScheme == .dark ? .clear : .gray.opacity(0.2),
            radius: 8,
            x: 0,
            y: 4
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(colorScheme == .dark ? Color(.systemGray4) : Color(.systemGray5), lineWidth: 1)
        )
        .padding(.vertical, 8)
    }
}

#Preview {
    CategoryView()
}
