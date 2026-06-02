//
//  DataLoader.swift
//  TimHortonsApp
//
//  Created by Cemar on 2026-06-01.
//

import Foundation

// Kini nga function maoy mo-basa sa imong coffeeData.json file
func loadCoffeeData() -> [Coffee] {
    // 1. Pangitaon ang file sa sulod sa app bundle
    guard let url = Bundle.main.url(forResource: "coffeeData", withExtension: "json") else {
        print("Error: JSON file 'coffeeData.json' not found in bundle.")
        return []
    }

    do {
        // 2. Kuhaon ang raw data gikan sa file
        let data = try Data(contentsOf: url)
        
        // 3. I-decode ang JSON ngadto sa array sa Coffee objects
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode([Coffee].self, from: data)
        
        print("Success: Loaded \(decodedData.count) coffee items.")
        return decodedData
        
    } catch {
        print("Decoding Error: \(error)")
        return []
    }
}
