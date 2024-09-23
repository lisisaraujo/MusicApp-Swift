//
//  File.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 23.09.24.
//

import Foundation
import SwiftData

@Model
class Song: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let artist: String
    let artworkURL: String
    
    init(title: String, artist: String, artworkURL: String) {
        self.title = title
        self.artist = artist
        self.artworkURL = artworkURL
    }
}
