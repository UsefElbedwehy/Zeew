//
//  HomeViewModel.swift
//  ZEEW_IOS
//
//  Created by Usef on 07/05/2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedCategory: FoodCategory = .pizza
    
    let featuredRestaurants: [Restaurant] = [
            Restaurant(
                name: "BURGER KING",
                imageName: "burger",
                category: .burger,
                rating: 4.9,
                ratingCount: 3000,
                discount: "10% OFF"
            ),
            Restaurant(
                name: "PIZZA HUT",
                imageName: "pizza",
                category: .pizza,
                rating: 4.7,
                ratingCount: 2500,
                discount: "15% OFF"
            )
        ]
    
    let restaurants: [Restaurant] = [
        Restaurant(
            name: "Zooba",
            imageName: "egy1",
            category: .egyptian,
            rating: 4.9,
            ratingCount: 5200,
            discount: "Free Hawawshi with 2 meals"
        ),
        Restaurant(
            name: "Koshary Abou Tarek",
            imageName: "koshary",
            category: .egyptian,
            rating: 4.7,
            ratingCount: 6800,
            discount: nil
        ),
        Restaurant(
            name: "Felfela",
            imageName: "egy2",
            category: .egyptian,
            rating: 4.5,
            ratingCount: 3900,
            discount: "10% OFF on Taameya"
        ),
        Restaurant(
            name: "Cook Door",
            imageName: "burger",
            category: .burger,
            rating: 4.6,
            ratingCount: 3100,
            discount: "Buy 1 Get 1 Free"
        ),
        Restaurant(
            name: "Pizza Hut Egypt",
            imageName: "pizza",
            category: .pizza,
            rating: 4.4,
            ratingCount: 2700,
            discount: "30% OFF on Family Meal"
        ),
        Restaurant(
            name: "O'Pasta",
            imageName: "pasta1",
            category: .pasta,
            rating: 4.3,
            ratingCount: 1800,
            discount: "Free Garlic Bread"
        ),
        Restaurant(
            name: "O'Pasta",
            imageName: "pasta2",
            category: .pasta,
            rating: 4.3,
            ratingCount: 1800,
            discount: "Free Garlic Bread"
        ),
        Restaurant(
            name: "El Tahrir Desserts",
            imageName: "dessert1",
            category: .dessert,
            rating: 4.8,
            ratingCount: 2100,
            discount: "Free Kunafa with 2 drinks"
        ),
        Restaurant(
            name: "El Baroon Desserts",
            imageName: "dessert2",
            category: .dessert,
            rating: 4.5,
            ratingCount: 1200,
            discount: "Free Basbosa with 2 drinks"
        ),
        Restaurant(
            name: "Nile Tea House",
            imageName: "drink",
            category: .drink,
            rating: 4.7,
            ratingCount: 3200,
            discount: "Free Mint Tea with Shisha"
        ),
        Restaurant(
            name: "Mahrous Seafood",
            imageName: "seafood1",
            category: .seafood,
            rating: 4.5,
            ratingCount: 1900,
            discount: "15% OFF on Sayadeya"
        ),
        Restaurant(
            name: "Hamza Seafood",
            imageName: "seafood2",
            category: .seafood,
            rating: 4.4,
            ratingCount: 1600,
            discount: "10% OFF on Sardeen"
        )
    ]
    
    var filteredRestaurants: [Restaurant] {
        if searchText.isEmpty {
            return restaurants.filter { $0.category == selectedCategory }
        } else {
            return restaurants.filter {
                $0.category == selectedCategory &&
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}


struct Category: Hashable {
    let name: String
    let icon: String
}
