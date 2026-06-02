//
//  CartItem 2.swift
//  TimHortonsApp
//
//  Created by Cemar on 2026-06-01.
//

import Foundation
import SwiftData

@Model
class CartItem {
    // Unique string ID for each database row entry
    @Attribute(.unique) var id: String
    
    // Since SwiftData cannot easily save a custom Struct directly,
    // we break down the Coffee object properties into separate variables here.
    var coffeeId: String
    var coffeeName: String
    var coffeePrice: Double
    var coffeeImage: String
    var quantity: Int
    
    // Initializer to create a new cart item using a Coffee object and a quantity
    init(id: String = UUID().uuidString, coffee: Coffee, quantity: Int) {
        self.id = id
        self.coffeeId = coffee.id
        self.coffeeName = coffee.name
        self.coffeePrice = coffee.price
        self.coffeeImage = coffee.image
        self.quantity = quantity
    }
}
