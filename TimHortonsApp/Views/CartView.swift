//
//  CartView.swift
//  TimHortonsApp
//

import SwiftUI

struct CartView: View {
    
    // Global state object injected via the environment context stack
    @EnvironmentObject var cart: CartManager
    
    // Structural navigation dismiss action handle
    @Environment(\.dismiss) var dismiss
    
    // Observed state pointer tracking the overarching global list container parameters
    @ObservedObject var store: OrderStore
    
    // UI layout configuration alert toggle flags
    @State private var showConfirmationAlert = false
    @State private var showSuccessAlert = false
    
    var body: some View {
        VStack {
            // Evaluates whether fallback states should trigger if cart items count is zero
            if cart.items.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "cart.badge.questionmark")
                        .font(.system(size: 70))
                        .foregroundColor(.gray)
                    Text("Your cart is empty")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                .frame(maxHeight: .infinity)
            } else {
                // Iterates smoothly across active stored persistent basket parameters records
                List {
                    ForEach(cart.items) { item in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(item.coffeeName)
                                    .font(.headline)
                                Spacer()
                                // Computes mathematical totals for item pricing fields dynamically
                                Text("$\(item.coffeePrice * Double(item.quantity), specifier: "%.2f")")
                                    .fontWeight(.semibold)
                            }
                            
                            // Custom binding hook mapping directly to interactive inline database updates
                            Stepper(
                                value: Binding(
                                    get: { item.quantity },
                                    set: { cart.updateQuantity(for: item, quantity: $0) }
                                ),
                                in: 1...10
                            ) {
                                Text("Quantity: \(item.quantity)")
                                    .font(.subheadline)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    // Attaches standard swiping gestures deletes modifiers automatically
                    .onDelete(perform: cart.remove)
                }
            }
            
            // Checkout Summary Actions Component Area Layout
            VStack(spacing: 15) {
                HStack {
                    Text("Total:")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Text("$\(cart.total, specifier: "%.2f")")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.brown)
                }
                .padding(.horizontal)
                
                Button(action: {
                    // Stage 1 Action: Display check gate warning prompt interface
                    showConfirmationAlert = true
                }) {
                    Text("Confirm Order")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(cart.items.isEmpty ? Color.gray : Color.brown)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(cart.items.isEmpty) // Block clicks contextually if basket counts equal zero
                .padding(.horizontal)
            }
            .padding(.vertical)
            .background(Color(.systemBackground))
            .shadow(radius: 5)
        }
        .navigationTitle("Your Cart")
        .navigationBarTitleDisplayMode(.inline)
        
        // INTERACTIVE ALERT INTERFACES ARCHITECTURE SECTION
        
        // Gate One Alert: Verification checkpoint logic engine handler
        .alert("Confirm Order", isPresented: $showConfirmationAlert) {
            Button("Yes, Finish", role: .none) {
                // Enqueue state rendering transitions smoothly using async clock adjustments
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showSuccessAlert = true
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to finish order?")
        }
        
        // Gate Two Alert: State modification persistence wrapper process
        .alert("Success!", isPresented: $showSuccessAlert) {
            Button("OK", role: .none) {
                // Update processing: Lock structural modifications metrics inside data models lists
                for index in 0..<store.orders.count {
                    store.orders[index].isSubmitted = true
                }
                
                cart.items.removeAll() // Wipe checkout view variables context clean
                dismiss()              // Return screen pop stack context frames cleanly
            }
        } message: {
            Text("Order Submitted! Your coffee run is on the way.")
        }
    }
}

#Preview {
    NavigationView {
        CartView(store: OrderStore())
            .environmentObject(CartManager())
    }
}
