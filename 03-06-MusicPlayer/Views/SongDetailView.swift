//
//  SongView.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 23.09.24.
//

import SwiftUI


struct SongDetailView: View {
    var title: String
    var artist: String
    var artworkUrl: String?
    var previewUrl: String?
    var trackViewUrl: String?
    var setCurrentSong: () -> Void

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: artworkUrl ?? "")) { phase in
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
            
            Text(title)
                .font(.title)
                .padding(.top)
            
            Text(artist)
                .font(.title2)
                .foregroundColor(.secondary)
            
            if previewUrl != nil {
                Button(action: {
                   setCurrentSong()
                }) {
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                    Text("Play Preview")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.leading, 5)
         
                     
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.pink)
                .foregroundColor(.white)
                .cornerRadius(15)
            }

            
            if let trackViewUrl = trackViewUrl, let url = URL(string: trackViewUrl) {
                Link(destination: url) {
                    Image("appleMusicBTN")
                        .resizable()
                        .frame(width: 150, height: 50)
                        .scaledToFill()
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
    }
}

#Preview {
 
    SongDetailView(
        title: "The Emptiness Machine",
        artist: "LINKIN PARK",
        artworkUrl: "https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/69/21/cf/6921cff3-7074-118a-ece2-4012450e6c75/093624839811.jpg/100x100bb.jpg",
        previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview122/v4/53/43/1f/53431f46-36d0-1a69-5c9b-f8f5bf9d82a5/mzaf_13055374056954277786.plus.aac.p.m4a",
        trackViewUrl: "https://music.apple.com/us/album/the-emptiness-machine/1766137051?i=1766137052", setCurrentSong: {}
    )
}
