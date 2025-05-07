//
//  Restaurant.swift
//  ZEEW_IOS
//
//  Created by Usef on 07/05/2025.
//

import Foundation



struct Restaurant: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let imageName: String
    let category: FoodCategory
    let rating: Double
    let ratingCount: Int
    let discount: String?
}

