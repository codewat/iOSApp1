# TimHortonsApp - Coffee Run Tracker ☕📱

A modern iOS application built using **SwiftUI** and **Combine** designed to stream line coffee runs. The app allows users to manage a dynamic list of active coffee orders, track elapsed time using an integrated timer view, and easily add new entries with custom drink options, sizes, and notes.

---

## 🚀 Features

* **Centered Dynamic Navigation Bar:** A custom brown-themed navigation header matching the classic coffee shop vibe, featuring integrated SF Symbols.
* **Static Timer Tracker:** A pinned `TimerView` at the top of the dashboard allowing users to track how long a coffee run has been active with **Start**, **Stop**, and **Reset** functionalities.
* **Floating Action Button:** A responsive "Add New Order" button layered seamlessly using a `ZStack` layout that remains accessible on top of the list view.
* **Dynamic JSON Data Parsing:** Robust object mapping supporting optional values (e.g., handling missing fields smoothly using Swift's Optional type checking).
* **Form Management & Automatic Navigation:** An automated order entry view that resets states efficiently and pops back to the main list upon a successful save action using environmental dismissing.

---

## 🛠️ Architecture & Tech Stack

* **Framework:** SwiftUI (Declarative UI)
* **State Management:** `@StateObject`, `@ObservedObject`, `@State`, and `@Environment`
* **Asynchronous Events:** Combine framework for handling reactive custom timer publishers (`Timer.publish`)
* **Data Format:** JSON & Swift `Codable` structs for robust serialization/deserialization
* **Version Control:** Git & GitHub integration managed through Xcode Source Control

---

## 📂 Project Structure Highlights

* **`ContentView.swift`**: The primary dashboard layout managing the main `ZStack`, pinned `TimerView`, scrollable orders `List`, and the overlay navigation button.
* **`AddOrderView.swift`**: The order generation form supporting user-input state parameters, list selection pickers, and automated dismissal hooks.
* **`TimerView.swift`**: An independent, self-contained modular component running automated clock increments decoupled from list-view touch gestures via custom button styles.
* **`Coffee.swift` / `Order.swift`**: Struct data models conforming to `Identifiable` and `Codable` protocols for error-free parsing workflows.

---

## 🔧 Installation & Setup

1. Clone this repository to your local Mac environment:
   ```bash
   git clone [https://github.com/codewat/iOSApp1.git](https://github.com/codewat/iOSApp1.git)
2. Open the project folder and double-click TimHortonsApp.xcodeproj to launch Xcode.

3. Select an iOS Simulator device (e.g., iPhone 15 or newer).

4. Press Cmd + R to Build and Run the application.

📄 License
This project is submitted as an academic development assignment. All rights reserved.
