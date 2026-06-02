//
//  DataLoader.swift
//  TimHortonsApp
//
//  Created by Cemar on 2026-06-01.
//

import Foundation

// This function reads the "coffeeData.json" file and converts it into a usable list of Coffee items
func loadCoffeeData() -> [Coffee] {
    
    // 1. Locate the "coffeeData.json" file within the main app bundle
    guard let url = Bundle.main.url(forResource: "coffeeData", withExtension: "json") else {
        // If the file is missing, print an error message and return an empty array
        print("Error: JSON file 'coffeeData.json' not found in bundle.")
        return []
    }

    do {
        // 2. Fetch the raw binary data from the located file URL
        let data = try Data(contentsOf: url)
        
        // 3. Initialize the JSONDecoder to convert the JSON data into Swift objects
        let decoder = JSONDecoder()
        
        // 4. Decode the raw JSON data into an array of Coffee objects ([Coffee])
        let decodedData = try decoder.decode([Coffee].self, from: data)
        
        // If successful, log the total count of loaded items and return the decoded data
        print("Success: Loaded \(decodedData.count) coffee items.")
        return decodedData
        
    } catch {
        // If a parsing or reading error occurs, log the specific error details
        print("Decoding Error: \(error)")
        return [] // Return an empty array to prevent the app from crashing
    }
}
