//
//  SongListItemView.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 23.09.24.
//

import SwiftUI
import SwiftData

struct SongListItemView: View {
    
    var song: Song
    
    var body: some View {
        HStack(spacing: 16) {
            Image(song.artworkURL)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 4)
            VStack(alignment: .leading, spacing: 4) {
                Text(song.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(song.artist)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 10)
        }
        .padding()
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Song.self, configurations: configuration)

    let sampleSong = Song(title: "Lost in Time", artist: "The Wanderers", artworkURL: "artwork1")

    container.mainContext.insert(sampleSong)

    return SongListItemView(song: sampleSong)
        .modelContainer(container)
    
    
}
