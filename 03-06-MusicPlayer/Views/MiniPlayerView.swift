//
//  MiniPlayerView.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 24.09.24.
//

import SwiftUI
import AVFoundation

struct MiniPlayerView: View {
    

    
    @State var isPlaying: Bool = false
    
    @Binding var currentSong: iTunesSong?

    
    
    @State private var player: AVPlayer?
    
    var body: some View {
        HStack {
                VStack(alignment: .leading) {
                    Text(currentSong?.artist ?? "")
                        .font(.headline)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    Text(currentSong?.title ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                .padding(.leading)

                Spacer()
                
                Button(action: {
                    togglePlayback()
                }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 30))
                        .padding()
                        .background(Color.secondary)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
       
        }
        .frame(maxWidth: .infinity, minHeight: 80)
        .background(Color.black.opacity(0.7))
        .cornerRadius(15)
        .shadow(radius: 10)
        .padding()
        
        .onAppear {
            setupPlayer()
        }
        .onDisappear {
            player?.pause() // Pause when view disappears
        }
        
        .onChange(of: currentSong){
            setupPlayer()
        }
    }
    
    private func setupPlayer() {
        guard let previewUrl = currentSong?.previewUrl, let url = URL(string: previewUrl) else { return }
        player = AVPlayer(url: url)
    }

    private func togglePlayback() {
        guard let player = player else { return }
        
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        
        isPlaying.toggle()
    }
    
}

#Preview {
    MiniPlayerView(currentSong: .constant(iTunesSong(
        id: 1766137051,
        title: "The Emptiness Machine",
        artist: "LINKIN PARK",
        artworkUrl: "https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/69/21/cf/6921cff3-7074-118a-ece2-4012450e6c75/093624839811.jpg/100x100bb.jpg",
        trackViewUrl: "https://music.apple.com/us/album/the-emptiness-machine/1766137051?i=1766137052",
        previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview122/v4/53/43/1f/53431f46-36d0-1a69-5c9b-f8f5bf9d82a5/mzaf_13055374056954277786.plus.aac.p.m4a"
    )))
}
