import SwiftUI
import Combine

struct AddOrderView: View {
    @ObservedObject var store: OrderStore
    @ObservedObject var cart: CartManager
    @Environment(\.dismiss) var dismiss

    // Load the menu array from the bundle JSON configuration data
    let menuCoffees: [Coffee] = loadCoffeeData()

    // Optional binding variable to track if an item is being edited (nil represents Add Mode)
    var editingOrder: Order?

    // Local state variables to bind form inputs dynamically
    @State private var name = ""
    @State private var selectedCoffee: Coffee
    @State private var size = "Medium"
    @State private var notes = ""
    @State private var quantity = 1
    
    // UI layout flag controllers
    @State private var showMenuSheet = false
    @State private var showNameWarning = false
    
    let sizes = ["Small", "Medium", "Large"]
    
    // Custom initializer designed to toggle dynamically between Add Mode and Edit Mode
    init(store: OrderStore, cart: CartManager, orderToEdit: Order? = nil) {
        self.store = store
        self.cart = cart
        self.editingOrder = orderToEdit
        
        let coffees = loadCoffeeData()
        
        if let order = orderToEdit {
            // EDIT MODE: Parse the existing dynamic payload name (e.g., "2x Latte" -> "Latte")
            let cleanDrinkName = order.drink.replacingOccurrences(of: #"\^\d+x "#, with: "", options: .regularExpression)
            if let matchedCoffee = coffees.first(where: { $0.name == cleanDrinkName }) {
                _selectedCoffee = State(initialValue: matchedCoffee)
            } else {
                _selectedCoffee = State(initialValue: coffees.first ?? Coffee(id: "0", name: "Select Coffee", description: "", price: 0.0, image: "", category: ""))
            }
            
            // Populate the form fields with existing historical entry parameters
            _name = State(initialValue: order.name)
            _size = State(initialValue: order.size)
            _notes = State(initialValue: order.notes)
            
            // Extract numerical prefix from prefix format string structure (e.g., "3x Mocha" -> 3)
            if let firstChar = order.drink.first, let parsedQty = Int(String(firstChar)) {
                _quantity = State(initialValue: parsedQty)
            }
        } else {
            // ADD MODE: Initialize form controls with safe base menu fallbacks
            if let firstCoffee = coffees.first {
                _selectedCoffee = State(initialValue: firstCoffee)
            } else {
                _selectedCoffee = State(initialValue: Coffee(id: "0", name: "Select Coffee", description: "", price: 0.0, image: "", category: ""))
            }
        }
    }
    
    var body: some View {
        Form {
            // Section 1: Customer Profile Context Identification
            Section(header: Text("Person")) {
                TextField("Name", text: $name)
                    // Reset name validation warning parameters fluidly as the user modifies text input values
                    .onChange(of: name) { oldValue, newValue in
                        if !newValue.trimmingCharacters(in: .whitespaces).isEmpty {
                            showNameWarning = false
                        }
                    }
                
                if showNameWarning {
                    Text("⚠️ Name is required to place an order.")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            
            // Section 2: Product Modifier Configurations Layout Architecture
            Section(header: Text("Order Selection")) {
                HStack {
                    Text("Coffee Menu")
                    Spacer()
                    
                    // Trigger custom presentation sheet to pick menu choices with image assets visible
                    Button(action: {
                        showMenuSheet = true
                    }) {
                        HStack {
                            Text(selectedCoffee.name)
                                .foregroundColor(.brown)
                                .fontWeight(.medium)
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.caption)
                                .foregroundColor(.brown)
                        }
                    }
                }
                
                Picker("Size", selection: $size) {
                    ForEach(sizes, id: \.self) { size in
                        Text(size)
                    }
                }
                
                Stepper(value: $quantity, in: 1...10) {
                    Text("Quantity: \(quantity) \(quantity == 1 ? "cup" : "cups")")
                }
                
                TextField("Notes (e.g., extra sugar)", text: $notes)
            }
            
            // Section 3: Data Core Process Actions Persistence Execution
            Section {
                Button(action: {
                    // Validation: Enforce name strings fields requirements checks safely
                    if name.trimmingCharacters(in: .whitespaces).isEmpty {
                        showNameWarning = true
                    } else {
                        if let order = editingOrder {
                            // EDIT MODE: Locate active tracking index pointer and update model properties
                            if let index = store.orders.firstIndex(where: { $0.id == order.id }) {
                                store.orders[index].name = name
                                store.orders[index].drink = "\(quantity)x \(selectedCoffee.name)"
                                store.orders[index].size = size
                                store.orders[index].notes = notes
                                store.orders[index].isSubmitted = false // Reset status if modifications are saved
                            }
                        } else {
                            // ADD MODE: Instatiate new model records and push updates globally
                            let newOrder = Order(
                                name: name,
                                drink: "\(quantity)x \(selectedCoffee.name)",
                                size: size,
                                notes: notes
                            )
                            store.addOrder(newOrder)
                            cart.add(selectedCoffee, quantity: quantity)
                        }
                        
                        dismiss() // Return user automatically to previous list container stack
                    }
                }) {
                    HStack {
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                        Text(editingOrder == nil ? "Save Order & Add to Cart" : "Update Order Details")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .foregroundColor(.white)
                }
                // Apply dynamic visual opacity formatting to indicate current input validity states
                .listRowBackground(name.trimmingCharacters(in: .whitespaces).isEmpty ? Color.brown.opacity(0.5) : Color.brown)
            }
        }
        .navigationTitle(editingOrder == nil ? "Add Order" : "Edit Order")
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(editingOrder == nil ? "Add Order" : "Edit Order")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
        .toolbarBackground(Color.brown, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        
        // Pop-up Menu Selector modal container interface details
        .sheet(isPresented: $showMenuSheet) {
            VStack {
                HStack {
                    Text("Select Coffee Menu")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    Button("Close") {
                        showMenuSheet = false
                    }
                    .foregroundColor(.brown)
                    .fontWeight(.semibold)
                }
                .padding()
                
                Divider()
                
                List(menuCoffees) { coffee in
                    Button(action: {
                        self.selectedCoffee = coffee
                        showMenuSheet = false
                    }) {
                        HStack(spacing: 15) {
                            Image(coffee.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                                .clipped()
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(coffee.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text(coffee.description)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                            }
                            
                            Spacer()
                            
                            Text("$\(coffee.price, specifier: "%.2f")")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.brown)
                        }
                    }
                }
            }
            .presentationDetents([.medium, .large]) // Native sheet sizing tracking handles
        }
    }
}

#Preview {
    NavigationView {
        AddOrderView(store: OrderStore(), cart: CartManager())
    }
}
