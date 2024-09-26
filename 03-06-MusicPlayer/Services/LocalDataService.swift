//
//  LocalDataService.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 24.09.24.
//

import Foundation

class LocalDataService {
    
    static let shared = LocalDataService()
    
    func fetchAllSongs(for country: String) -> [TopSong] {
        var path: String?
        
        // determine the path based on the selected country
        switch country.lowercased() {
        case "germany":
            path = Bundle.main.path(forResource: "DataGermany", ofType: "json")
        case "us":
            path = Bundle.main.path(forResource: "DataUS", ofType: "json")
        case "uk":
            path = Bundle.main.path(forResource: "DataUK", ofType: "json")
        case "france":
            path = Bundle.main.path(forResource: "DataFrance", ofType: "json")
        case "japan":
            path = Bundle.main.path(forResource: "DataJapan", ofType: "json")
        default:
            print("Country not supported or file not found!")
            return []
        }
        
        
        guard let validPath = path else {
            print("File doesn't exist!")
            return []
        }
        
        do {
            // read data from local file
            let data = try Data(contentsOf: URL(fileURLWithPath: validPath))
            
            // decode JSON into Response model
            let response = try JSONDecoder().decode(Response.self, from: data)
            
            // return the array of songs
            return response.feed.results
            
        } catch {
            print("Error decoding JSON: \(error)")
            return []
        }
    }
}
