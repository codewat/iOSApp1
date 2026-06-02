import SwiftUI
import Combine

struct TimerView: View {
    // State variables to track numerical duration and active clock toggles
    @State private var time = 0
    @State private var running = false
    
    // A Combine reactive publisher that emits the current date/time every 1 second on the main thread loop
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 8) { // Added a small spacing between elements
            
            // Timer Display numerical text element
            Text("Time: \(time)s")
                .font(.title2) // Sized perfectly to fit the List header area
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            // Buttons Row Container matching alignment formats
            HStack(spacing: 15) { // Aligns buttons side-by-side
                
                // 1. Interactive Start / Stop Action Button component
                Button(action: {
                    // Toggles the boolean flag state back and forth
                    running.toggle()
                }) {
                    Text(running ? "Stop" : "Start")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(running ? Color.red : Color.green) // Red for Stop, Green for Start
                        .cornerRadius(8)
                }
                .buttonStyle(.plain) // Standardizes click boundaries inside container rows
                
               // 2. Interactive Reset Action Button component
                Button(action: {
                    running = false // Stops the timer ticking immediately
                    time = 0        // Resets the total elapsed count back to zero
                }) {
                    Text("Reset")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.blue) // Blue background for reset action execution
                        .cornerRadius(8)
                }
                .buttonStyle(.plain) // Prevents click target layout leaks inside lists
                
            } // End of HStack
        } // End of VStack
        // Listens directly to the Combine system clock publisher stream
        .onReceive(timer) { _ in
            // Business Rule: Increment duration counts exclusively if the running flag matches true
            if running {
                time += 1
            }
        }
    }
}

#Preview {
    TimerView()
}
