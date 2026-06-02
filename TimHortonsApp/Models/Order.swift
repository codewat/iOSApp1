//
//  Order.swift
//  TimHortonsApp
//
//  Created by Cemar on 2026-05-21.
//

import Foundation
// we need to create a struct of variable in this class
// identifiable (ID) Codable

struct Order: Identifiable, Codable {
    var id = UUID()
    var name: String
    var drink: String
    var size: String
    var notes: String
    var isSubmitted: Bool = false
  //  var quantity: Int
  //  var price: Double
}
