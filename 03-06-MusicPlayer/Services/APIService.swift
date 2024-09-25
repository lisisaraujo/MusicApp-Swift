//
//  APIService.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 25.09.24.
//

import SwiftUI

enum HTTPError: Error {
    case invalidURL, fetchFailed
    
    var message: String {
        switch self {
        case .invalidURL: "Invalid URL"
        case .fetchFailed: "Error fetching data"
        }
    }
}

func getSongs(countryCode: String) async throws -> [Song] {
    let urlString = "https://rss.applemarketingtools.com/api/v2/\(countryCode)/music/most-played/10/songs.json"
    
    guard let url = URL(string: urlString) else {
        throw HTTPError.invalidURL
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    let response = try JSONDecoder().decode(Response.self, from: data)
    return response.feed.results
}


