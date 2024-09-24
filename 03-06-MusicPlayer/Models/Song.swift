//
//  File.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 23.09.24.
//

import Foundation

struct Response: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let results: [Song]
}


struct Song: Codable, Identifiable {
    let id: String
    let name: String
    let artistName: String
    let artworkUrl100: String
    let url: String
 }
