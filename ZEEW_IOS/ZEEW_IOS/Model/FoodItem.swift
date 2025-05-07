//
//  FoodItem.swift
//  ZEEW
//
//  Created by Usef on 07/05/2025.
//

import Foundation

struct FoodItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    var toppings: [String] = []
    var sideOptions: [String] = []
}
