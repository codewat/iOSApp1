//
//  SplashScreen.swift
//  TimHortonsApp
//
//  Created by Cemar on 2026-05-29.
//

import SwiftUI

struct SplashView: View {
    
    // State variables to control routing flow and animation state values
    @State private var isActive = false
    @State private var scale: CGFloat = 0.8
    
    var body: some View {
        
        // Conditional routing block to switch screen frames dynamically
        if isActive {
            // Transitions to the main application interface once the timer completes
            ContentView()
        } else {
            
            ZStack {
                // Background brand color layout configuration properties
                Color.brown
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    // 🖼️ Animated App Branding Logo
                    Image("Icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .scaleEffect(scale)
                        .onAppear {
                            // Triggers a continuous ease-in-out breathing/pulsing effect
                            withAnimation(
                                .easeInOut(duration: 1.2)
                                .repeatForever(autoreverses: true)
                            ) {
                                scale = 1.0
                            }
                        }
                    
                    // Application Title Header Label
                    Text("Coffee Run ☕")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .onAppear {
                // Sets up an asynchronous delay timer to display the splash layer for 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    // Smoothly animate the screen swap transition state change
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    // Canvas target handle to preview splash layer formatting cleanly
    SplashView()
}
