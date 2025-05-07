//
//  FoodCategory.swift
//  ZEEW_IOS
//
//  Created by Usef on 07/05/2025.
//

import Foundation
import SwiftUI

enum FoodCategory: String, CaseIterable, Identifiable {
    case pizza = "PIZZA"
    case burger = "BURGER"
    case drink = "DRINKS"
    case rice = "RICE"
    case egyptian = "EGYPTIAN"
    case pasta = "PASTA"
    case dessert = "DESSERTS"
    case seafood = "SEAFOOD"
    case coffee = "COFFEE"
    
    var id: String { self.rawValue }
    
    var iconName: String {
        switch self {
        case .pizza: return "fork.knife"
        case .burger: return "flame.fill"
        case .drink: return "wineglass.fill"
        case .rice: return "takeoutbag.and.cup.and.straw"
        case .egyptian: return "leaf.fill"
        case .pasta: return "fork.knife"
        case .dessert: return "birthday.cake.fill"
        case .seafood: return "fish.fill"
        case .coffee: return "cup.and.saucer.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .pizza: return Color(red: 0.95, green: 0.4, blue: 0.2)
        case .burger: return Color(red: 0.8, green: 0.5, blue: 0.2)
        case .drink: return Color(red: 0.1, green: 0.6, blue: 0.9)
        case .rice: return Color(red: 0.3, green: 0.7, blue: 0.3)
        case .egyptian: return Color(red: 0.9, green: 0.7, blue: 0.1)
        case .pasta: return Color(red: 0.8, green: 0.6, blue: 0.4) // Creamy pasta color
        case .dessert: return Color(red: 0.9, green: 0.2, blue: 0.6)
        case .seafood: return Color(red: 0.2, green: 0.5, blue: 0.8)
        case .coffee: return Color(red: 0.4, green: 0.3, blue: 0.2)
        }
    }
    
    // Localized names for Egyptian market
    var localizedName: String {
        switch self {
        case .egyptian: return "مصرية"
        case .dessert: return "حلويات"
        case .pasta: return "مكرونة"
        case .coffee: return "قهوة"
        default: return self.rawValue
        }
    }
}
