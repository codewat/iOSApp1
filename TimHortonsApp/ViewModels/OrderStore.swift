//
//  OrderStore.swift
//  TimHortonsApp
//
//  Created by Cemar on 2026-05-21.
//

import Foundation
import SwiftUI
import Combine

// Manages the collection of active custom run orders and publishes changes to SwiftUI views
class OrderStore: ObservableObject {
    
    // Published array that automatically triggers a UI refresh whenever an order is added or modified
    @Published var orders: [Order] = []
    
    // Appends a newly created custom order into the tracking list
    func addOrder(_ order: Order) {
        orders.append(order)
    }
}
