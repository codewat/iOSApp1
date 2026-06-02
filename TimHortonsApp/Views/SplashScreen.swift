//
//  SplashScreen.swift
//  TimHortonsApp
//
//  Created by Cemar on 2026-05-29.
//


import SwiftUI

struct SplashView: View {
    
    @State private var isActive = false
    @State private var scale: CGFloat = 0.8
    
    var body: some View {
        
        if isActive {
            ContentView()
        } else {
            
            ZStack {
                Color.brown
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    // 💡 Giilisan ang "icon" ngadto sa "Icon" ug gi-adjust ang sizing modifiers
                    Image("Icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120) // Pwede ra nimo usbon ang gidak-on diri
                        .scaleEffect(scale)
                        .onAppear {
                            withAnimation(
                                .easeInOut(duration: 1.2)
                                .repeatForever(autoreverses: true)
                            ) {
                                scale = 1.0
                            }
                        }
                    
                    // 💡 Giilisan para mosubay sa ngalan sa imong app nga "Coffee Run"
                    Text("Coffee Run ☕")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
