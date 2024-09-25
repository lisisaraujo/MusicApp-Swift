//
//  SongView.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 23.09.24.
//

import SwiftUI

struct SongDetailView: View {
    @State var song: Song
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: song.artworkUrl100)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 300)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300)
                case .empty:
                    ProgressView()
                        .frame(maxWidth: 300)
                @unknown default:
                    EmptyView()
                }
            }
            
            Text(song.name)
                .font(.title)
                .padding(.top)
            
            Text(song.artistName)
                .font(.title2)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}
