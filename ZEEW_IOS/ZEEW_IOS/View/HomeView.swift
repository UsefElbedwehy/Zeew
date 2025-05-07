//
//  HomeView.swift
//  ZEEW_IOS
//
//  Created by Usef on 07/05/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var showCart = false
    @State private var currentPage = 0
    var body: some View {
        NavigationStack {

            ZStack {

                AppBackGround()

                VStack(spacing: 0) {
                    // Header with location and cart
                    headerSection

                    // Search bar
                    CustomSearchView(searchText: .constant(""))
                    
                    ScrollView {
                        // Food categories
                        categoriesSection

                        // Featured offer
                        featuredSection

                        // Restaurants list
                        restaurantsSection
                    }
                }
                .navigationDestination(isPresented: $showCart) {
                    Text("Cart View")  // Replace with your CartView
                }
            }
        }
    }

    // MARK: - Subviews

    private var headerSection: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.primary)
                .padding(.leading)
            Spacer()

            VStack(alignment: .center, spacing: 2) {
                Text("Your Location")
                    .font(.caption)
                    .foregroundColor(.gray)

                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.green)
                    Text("Savar, Dhaka")
                        .font(.headline)
                }
            }

            Spacer()

            Button {
                showCart = true
            } label: {
                ZStack {
                    Image(systemName: "cart")
                        .foregroundStyle(.black)
                        .font(.title2)
                        .padding(10)
                        .background(.clear)
                        .clipShape(Circle())
                        .overlay(NotificationBadge(count: 3))
                    Circle()
                        .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                        .frame(width: 50, height: 50)
                }
            }
            .padding(.trailing)
        }
        .padding()
    }

    private var categoriesSection: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(FoodCategory.allCases) { category in
                        CategoryButton(
                            category: category,
                            isSelected: viewModel.selectedCategory == category
                        ) {
                            viewModel.selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.bottom, 10)
    }

    private var featuredSection: some View {
        VStack(alignment: .leading) {
            Text("Today's Special")
                .font(.headline)
                .padding(.horizontal)

            // 1. Simple TabView implementation
            TabView(selection: $currentPage) {
                ForEach(viewModel.featuredRestaurants.indices, id: \.self) {
                    index in
                    FeaturedRestaurantCard(
                        restaurant: viewModel.featuredRestaurants[index]
                    )
                    .padding(.horizontal, 16)
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 200)

            // 2. Simple dots indicator
            HStack(spacing: 8) {
                Spacer()
                ForEach(viewModel.featuredRestaurants.indices, id: \.self) {
                    index in
                    Circle()
                        .fill(
                            currentPage == index
                                ? Color.green : Color.green.opacity(0.3)
                        )
                        .frame(width: 8, height: 8)
                        .onTapGesture {
                            withAnimation {
                                currentPage = index
                            }
                        }
                }
                Spacer()
            }
            .padding(.top, 4)
        }
        .padding(.bottom, 8)
    }

    // Featured Restaurant Card View
    struct FeaturedRestaurantCard: View {
        let restaurant: Restaurant

        var body: some View {
            ZStack(alignment: .bottomLeading) {
                Image(restaurant.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .clipped()
                    .cornerRadius(12)
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .clear, .black.opacity(0.7),
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .cornerRadius(12)
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text(restaurant.category.rawValue)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)

                    Text("Today's Hot offer")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))

                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.caption)

                        Text(
                            "\(restaurant.rating, specifier: "%.1f") (\(restaurant.ratingCount.roundedWithAbbreviation)+ Rating)"
                        )
                        .font(.caption)
                        .foregroundColor(.white)
                    }
                }
                .padding(.leading, 30)
                .padding(.bottom, 20)

                if let discount = restaurant.discount {
                    Text(discount)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.green)
                        .cornerRadius(8)
                        .padding([.top, .trailing], 16)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
    }

    private var restaurantsSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Restaurants")
                    .font(.headline)
                
                Spacer()
                
                Button("View All") {}
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            
            // Grid layout with 2 columns
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 16),
                    GridItem(.flexible(), spacing: 16)
                ],
                spacing: 16
            ) {
                ForEach(viewModel.filteredRestaurants) { restaurant in
                    RestaurantCard(restaurant: restaurant)
                }
            }
            .padding(.horizontal)
        }
        .padding(.bottom, 20)
    }
}

// MARK: - Components

struct CategoryButton: View {
    let category: FoodCategory
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: category.iconName)
                    .font(.title2)
                    .foregroundColor(isSelected ? .white : .black)

                Text(category.rawValue)
                    .font(.caption2)
                    .foregroundColor(isSelected ? .white : .black)
            }
            .frame(width: 70)
            .padding(.horizontal, 10)
            .padding(.vertical, 25)
            .background(
                isSelected ? .green : Color(.systemGray6)
            )
            .cornerRadius(10)
        }
    }
}

struct RestaurantCard: View {
    let restaurant: Restaurant
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            // Image with discount badge
            ZStack(alignment: .topTrailing) {
                Image(restaurant.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 170, height: 120)
                    .clipped()
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray5), lineWidth: 1)
                    )
                
                if let discount = restaurant.discount {
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
            
            // Restaurant name
            Text(restaurant.name)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .lineLimit(1)
                .frame(width: 160)
                .padding(.horizontal, 8)
            
            // Add to cart button
            Button(action: {
                print("Added to cart: \(restaurant.name)")
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
        .padding(.bottom,12)
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

// Button animation helper
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct NotificationBadge: View {
    let count: Int

    var body: some View {
        if count > 0 {
            Text("\(count)")
                .font(.caption2)
                .bold()
                .foregroundColor(.white)
                .padding(4)
                .background(Color.red)
                .clipShape(Circle())
                .offset(x: 10, y: -10)
        }
    }
}

// MARK: - Extensions

extension Int {
    var roundedWithAbbreviation: String {
        let number = Double(self)
        switch number {
        case 1_000_000...:
            return "\(Int(number / 1_000_000))M"
        case 1_000...:
            return "\(Int(number / 1_000))K"
        default:
            return "\(self)"
        }
    }
}

// MARK: - Preview

#Preview {
    HomeView()
}
