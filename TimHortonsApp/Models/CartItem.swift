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
    @Attribute(.unique) var id: String // Unique string ID para sa database row
    
    // Tungod kay dili pa dali i-save ang custom Struct directly sa SwiftData,
    // atong bungkagon ang mga attributes sa kape nga gi-order dire sa CartItem.
    var coffeeId: String
    var coffeeName: String
    var coffeePrice: Double
    var coffeeImage: String
    var quantity: Int
    
    init(id: String = UUID().uuidString, coffee: Coffee, quantity: Int) {
        self.id = id
        self.coffeeId = coffee.id
        self.coffeeName = coffee.name
        self.coffeePrice = coffee.price
        self.coffeeImage = coffee.image
        self.quantity = quantity
    }
}