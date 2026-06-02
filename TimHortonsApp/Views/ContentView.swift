import SwiftUI

struct ContentView: View {
    // 1. Manages the custom manual group orders state array
    @StateObject var store = OrderStore()
    
    // 2. Manages the shopping cart lifecycle data array independently
    @StateObject var cart = CartManager()
    
    var body: some View {
        NavigationView {
            // ZStack layer stacks background surfaces, the scrollable list, and floating items on top of each other
            ZStack(alignment: .bottom) {
                
                // Main Vertical Layout Container matching top screen alignments
                VStack(spacing: 0) {
                    
                    // CUSTOM TOOLBAR WITH BRANDING & CART BUTTON
                    ZStack {
                        // Left-aligned brand logo placement block
                        HStack {
                            Image("Icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            Spacer()
                        }
                        
                        // Centered navigation title text layer display
                        Text("Tim Hortons Run")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        // CART NAVIGATION BUTTON WITH DYNAMIC ITEM COUNT BADGE
                        HStack {
                            Spacer()
                            
                            // Forwards global context managers elements inside the subview stack destination
                            NavigationLink(destination: CartView(store: store).environmentObject(cart)) {
                                ZStack(alignment: .topTrailing) {
                                    Image(systemName: "cart.fill")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(Color.white.opacity(0.2))
                                        .clipShape(Circle())
                                    
                                    // Compute the current absolute quantity values matching items present inside the array
                                    let itemCount = cart.items.reduce(0) { $0 + $1.quantity }
                                    
                                    // Conditionally display structural numeric badges if counts are above zero
                                    if itemCount > 0 {
                                        Text("\(itemCount)")
                                            .font(.caption2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .frame(width: 18, height: 18)
                                            .background(Color.red)
                                            .clipShape(Circle())
                                            .offset(x: 5, y: -5)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.brown) // Solid brand brown theme container fill
                    
                    // TIMER CONTAINER DECORATION BLOCK
                    HStack {
                        Spacer()
                        TimerView()
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .background(Color.brown.opacity(0.1))
                    
                    // LIST LAYER: ACTIVE CUSTOM MANUALLY ADDED ENTRIES RECORDS
                    List {
                        Section(header: Text("Active Run Orders:")) {
                            if store.orders.isEmpty {
                                // Fallback empty state content formatting text
                                Text("No active custom orders yet.")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .italic()
                            } else {
                                // Iterate and render lines rows elements based on existing model references loops
                                ForEach(store.orders) { order in
                                    // Navigation link forward hook allowing data updates in-place via Edit Mode mapping
                                    NavigationLink(destination: AddOrderView(store: store, cart: cart, orderToEdit: order)) {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(order.name)
                                                    .font(.headline)
                                                    // Fade text color dynamically into gray to indicate a locked row status
                                                    .foregroundColor(order.isSubmitted ? .gray : .primary)
                                                
                                                Text("\(order.size) - \(order.drink)")
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                                
                                                if !order.notes.isEmpty {
                                                    Text(order.notes)
                                                        .font(.caption)
                                                        .foregroundColor(.brown)
                                                }
                                            }
                                            
                                            Spacer()
                                            
                                            // Visual verification indicator verifying submission states processing logs
                                            if order.isSubmitted {
                                                HStack(spacing: 4) {
                                                    Image(systemName: "checkmark.circle.fill")
                                                    Text("Order Submitted")
                                                }
                                                .font(.caption)
                                                .fontWeight(.bold)
                                                .foregroundColor(.green)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(Color.green.opacity(0.1))
                                                .cornerRadius(5)
                                            }
                                        }
                                        .padding(.vertical, 2)
                                    }
                                    // BUSINESS RULE: Disable editing selections loops permanently if the order item record status isSubmitted evaluates to true
                                    .disabled(order.isSubmitted)
                                }
                            }
                        }
                    }
                    // Apply programmatic safety bottom offsets margins to keep scrolling ranges clear from floating interactive elements
                    .padding(.bottom, cart.items.isEmpty ? 70 : 130)
                    
                } // End of VStack
                
                if !cart.items.isEmpty {
                    // Wrapped inside a NavigationLink to redirect users straight to CartView
                    NavigationLink(destination: CartView(store: store).environmentObject(cart)) {
                        HStack {
                            // Mini cart indicator row icon alignment setup
                            Image(systemName: "cart.fill")
                                .foregroundColor(.white)
                            
                            Text("Items in Cart: \(cart.items.reduce(0) { $0 + $1.quantity })")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("Total: $\(cart.total, specifier: "%.2f")")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            // Arrow indicator signaling to users that this component is interactive/clickable
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding()
                        .background(Color.black.opacity(0.85)) // Darkened overlay opacity slightly for standard button style contrasts
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 80)
                    }
                }
                
                // FLOATING ACTION TRIGGER COMPONENT BUTTON (Defaults to Add Mode context setup properties automatically)
                NavigationLink(destination: AddOrderView(store: store, cart: cart)) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Custom Order")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.brown)
                    .cornerRadius(15)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                }
                
            } // End of ZStack
            .navigationBarHidden(true) // Yield absolute layout flow sizing constraints directly to the custom toolbar implementation container
        }
    }
}

#Preview {
    ContentView()
}
