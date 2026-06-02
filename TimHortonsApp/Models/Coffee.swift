//
//  Coffee.swift
//  TimHortonsApp
//
//  Created by Cemar on 2026-06-01.
//

import Foundation

// Represents a single coffee item template from the JSON menu dataset
struct Coffee: Identifiable, Codable, Hashable {
    // Identifiable: Requires a unique 'id' so SwiftUI Lists can track each item individually
    let id: String
    
    let name: String
    let description: String
    let price: Double
    let image: String
    let category: String
}
