//
//  CoffeeItem.swift
//  TimHortonsApp
//
//  Created by Cemar on 2026-05-28.
//

import Foundation
import SwiftData

// @Model macro tells Xcode to automatically manage this class schema as a persistent database table
@Model
class CoffeeItem {
    // Unique attribute constraint ensures no duplicate entries exist inside the database row mapping
    @Attribute(.unique) var id: String
    
    var name: String
    // Renamed to 'coffeeDescription' to safely avoid naming conflicts with the built-in Swift 'description' keyword
    var coffeeDescription: String
    var price: Double
    var image: String
    var category: String
    
    // Class definitions require an explicit initializer to map parameters during object instantiation
    init(id: String, name: String, coffeeDescription: String, price: Double, image: String, category: String) {
        self.id = id
        self.name = name
        self.coffeeDescription = coffeeDescription
        self.price = price
        self.image = image
        self.category = category
    }
}
