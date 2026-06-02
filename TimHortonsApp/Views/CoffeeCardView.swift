//
//  CoffeeCardView.swift
//  TimHortonsApp
//
//  Created by Cemar on 2026-06-01.
//

import SwiftUI

struct CoffeeCardView: View {
    // The coffee model data injected dynamically from the decoded JSON menu list
    let coffee: Coffee
    
    // EnvironmentObject allows global cart management interactions from any view context
    @EnvironmentObject var cart: CartManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // 🖼️ Coffee Image
            // Make sure the image filename string values inside the JSON file (e.g., "coffee1")
            // match your asset keys inside Assets.xcassets precisely
            Image(coffee.image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .cornerRadius(10)
                .clipped()
            
            // 🏷️ Name & Description Info Block
            VStack(alignment: .leading, spacing: 4) {
                Text(coffee.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(coffee.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2) // Truncate the description to a maximum of two lines for clean formatting
            }
            
            Spacer(minLength: 5)
            
            // 💰 Price & Add Action Section
            HStack {
                Text("$\(coffee.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.brown)
                
                Spacer()
                
                // Triggers an addition process mutation to append this item context into the basket records
                Button(action: {
                    cart.add(coffee)
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.brown)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    // Setup standard mocking dependencies to ensure Canvas renders smoothly without compile failures
    CoffeeCardView(coffee: Coffee(id: "1", name: "Espresso", description: "Very strong coffee", price: 2.99, image: "coffee", category: "Hot"))
        .environmentObject(CartManager())
        .frame(width: 200)
}
