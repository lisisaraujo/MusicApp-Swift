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
    var artworkUrl100: String
    let url: String
 }

// itunes structs

struct ItunesResponse: Codable {
    let results: [Song2]
}

struct Song2: Identifiable, Codable {
    let id: Int
    let title: String
    let artist: String
    let artworkUrl: String?
    let trackViewUrl: String?

    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case title = "trackName"
        case artist = "artistName"
        case artworkUrl = "artworkUrl100"
        case trackViewUrl
    }
}
