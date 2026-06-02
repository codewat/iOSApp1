import SwiftUI

struct ContentView: View {
    @StateObject var store = OrderStore()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    
                    // 💡 KINI ANG IMONG CUSTOM TOOLBAR (Gi-center na ang Text)
                    ZStack {
                        // 1. Ang Logo (Naka-align sa pinakawala)
                        HStack {
                            Image("Icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                            Spacer() // Itulod ang logo sa wala
                        }
                        
                        // 2. Ang Text (Awtomatiko kining ma-center sa ZStack)
                        Text("Coffee Run Order")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.brown) // Imong solid brown background
                    
                    // TIMER VIEW CONTAINER
                    HStack {
                        Spacer()
                        TimerView()
                        Spacer()
                    }
                    .padding()
                    .background(Color.brown.opacity(0.1))
                    
                    // LIST LAYER
                    List {
                        Section(header: Text("Active Orders:")) {
                            ForEach(store.orders) { order in
                                VStack(alignment: .leading) {
                                    Text(order.name)
                                        .font(.headline)
                                    Text("\(order.size) \(order.drink)")
                                    if !order.notes.isEmpty {
                                        Text(order.notes)
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                    }
                } // End of VStack
                
                // FLOATING ACTION BUTTON
                NavigationLink(destination: AddOrderView(store: store)) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add New Order")
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
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ContentView()
}

#Preview {
    ContentView()
}
