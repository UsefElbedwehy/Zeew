//
//  Order.swift
//  ZEEW
//
//  Created by Usef on 07/05/2025.
//

import Foundation

struct Order {
    var items: [FoodItem]
    var total: Double {
        items.reduce(0) { $0 + $1.price }
    }
    var deliveryFee: Double = 2.99
    var taxes: Double { total * 0.1 } // 10% tax
    var payableTotal: Double { total + deliveryFee + taxes }
}
