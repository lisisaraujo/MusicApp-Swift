//
//  MiniPlayerView.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 24.09.24.
//

import SwiftUI

struct MiniPlayerView: View {
    @Binding var currentSong: Song?
    @State private var isPlaying: Bool = false
    
    var body: some View {
        HStack {
            if let song = currentSong {
               
                VStack(alignment: .leading) {
                    Text(song.name)
                        .font(.headline)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    Text(song.artistName)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                .padding(.leading)

                Spacer()
                
                Button(action: {
                    isPlaying.toggle()
                }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 30))
                        .padding()
                        .background(Color.secondary)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
            } else {
                Text("No song playing")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, minHeight: 80)
        .background(Color.black.opacity(0.7))
        .cornerRadius(15)
        .shadow(radius: 10)
        .padding()
    }
    
}

#Preview {
    MiniPlayerView(currentSong: Binding.constant(Song(id: "1766137051", name: "The Emptiness Machine", artistName: "LINKIN PARK", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/69/21/cf/6921cff3-7074-118a-ece2-4012450e6c75/093624839811.jpg/100x100bb.jpg", url: "#")))
}
