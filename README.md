# Tim Hortons Coffee Run App ☕🏃‍♂️

An iOS application built using **SwiftUI** and **SwiftData** designed to streamline group coffee runs. This app allows users to manage a shared list of custom orders, track item totals, set timers, and seamlessly handle order modifications through persistent storage.

## 🚀 Features (Assignment 2 Updates)
* **Persistent Storage with SwiftData**: Integrated structural database models to ensure cart entries persist safely across app launches.
* **Dynamic Splash Screen**: Added an animated, pulsing onboarding launch screen that automatically forwards users to the main container.
* **Advanced Order Customization (Add & Edit Mode)**: Upgraded the order view with a polymorphic layout that detects historical order data to automatically toggle between creating a new entry and modifying an existing one.
* **Robust Input Validation**: Implemented safe text trimming algorithms to enforce required fields and protect tracking lists against empty inputs.
* **Interactive Floating Cart Link**: Replaced the static overlay banner with a fully clickable dynamic shortcut that routes users straight to the checking cart layout, showcasing running quantity limits capped at 10 items.
* **Combine Timer Sync**: Features an isolated background clock utility built with Combine framework publishers for precise time metrics synchronization.

---

## 🛠️ Architecture & Tech Stack
* **Framework**: SwiftUI (Declarative UI Lifecycle)
* **Database Schema Model**: SwiftData (`@Model`, `@Attribute(.unique)`)
* **State Control Design**: Architecture patterns utilizing `@StateObject`, `@ObservedObject`, `@Published`, and `@EnvironmentObject`.
* **Reactive Pipelines**: Combine Framework (`Timer.publish`)
* **Data Parsing Strategy**: Native standard decoding mapping utilities (`JSONDecoder`) using raw asset payloads.

---

## 📂 Project Structure
* `TimHortonsAppApp.swift`: Root lifecycle entry manager deploying global persistent databases context layers.
* `SplashView.swift`: Splash interface launching entry delays and view state switches animations.
* `ContentView.swift`: Core application window coordinating group orders grid layout layers.
* `AddOrderView.swift`: Configurator module handling text parameter validation constraints and edit context lookups.
* `CartView.swift`: Subview controlling item deletions gestures tracking calculations, totals parameters adjustments, and final submission gates closures.
* `CartManager.swift` & `OrderStore.swift`: Business logic engines modifying state environments across view hierarchies.
* `CoffeeItem.swift` & `CartItem.swift`: SwiftData core models representations.
* `DataLoader.swift`: Utility package decoding static `coffeeData.json` assets sheets into usable layout collections.

---

## 💻 Environment Requirements
* **Mac Machine**: MacBook Air / MacBook Pro running macOS Sonoma or later
* **IDE Application**: Xcode 15+ 
* **Deployment Targets**: iOS 17.0+
