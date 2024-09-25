//
//  ItunesSongDetailView.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 25.09.24.
//

import SwiftUI


struct ItunesSongDetailView: View {
    @State var song: Song2
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: song.artworkUrl!)) { phase in
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
            
            Text(song.title)
                .font(.title)
                .padding(.top)
            
            Text(song.artist)
                .font(.title2)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}


#Preview {
    ItunesSongDetailView(song: Song2(
        id: 1766137051,
        title: "The Emptiness Machine",
        artist: "LINKIN PARK",
        artworkUrl: "https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/69/21/cf/6921cff3-7074-118a-ece2-4012450e6c75/093624839811.jpg/100x100bb.jpg",
        trackViewUrl: "https://music.apple.com/us/album/the-emptiness-machine/1766137051?i=1766137052"
    ))
}
