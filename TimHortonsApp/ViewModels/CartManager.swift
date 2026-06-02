import Foundation
import Combine
import SwiftUI

// Manages the persistent shopping cart state and handles business logic
class CartManager: ObservableObject {
    
    // Published array to automatically update SwiftUI views whenever items change
    @Published var items: [CartItem] = []
    
    // Adds a coffee item to the cart with a specific quantity (capped at a maximum of 10)
    func add(_ coffee: Coffee, quantity: Int = 1) {
        if let index = items.firstIndex(where: { $0.coffeeId == coffee.id }) {
            // If item already exists in the cart, add the new quantity to the existing one
            let potentialQuantity = items[index].quantity + quantity
            // Use min(X, 10) to cap the final quantity at a maximum of 10 cups
            items[index].quantity = min(potentialQuantity, 10)
        } else {
            // If it's a new item, add it directly to the cart array using the specified quantity (capped at 10)
            items.append(CartItem(coffee: coffee, quantity: min(quantity, 10)))
        }
    }
    
    // Removes items from the cart list using swipe-to-delete offsets
    func remove(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    // Updates the quantity of a specific cart item directly from Stepper controls
    func updateQuantity(for item: CartItem, quantity: Int) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity = quantity
        }
    }
    
    // Computed property that calculates the grand total price of all items in the cart
    var total: Double {
        items.reduce(0) { $0 + ($1.coffeePrice * Double($1.quantity)) }
    }
}
