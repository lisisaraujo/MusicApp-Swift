//
//  ItunesSongDetailView.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 25.09.24.
//

import SwiftUI
import AVFoundation

struct ItunesSongDetailView: View {
    @State var song: iTunesSong
    @State private var player: AVPlayer?
    @State private var isPlaying = false
    
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

            
       
            Button(action: {
                togglePlayback()
            }) {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
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
            
   
             
                Link(destination: URL(string: song.trackViewUrl ?? "")!) {
                    Image("appleMusicBTN")
                        .resizable()
                        .frame(width: 150, height: 50)
                        .scaledToFill()
                }
                .buttonStyle(PlainButtonStyle())
         
           
         

        }
        .padding()
        .onAppear {
            setupPlayer()
        }
        .onDisappear {
            player?.pause() // pause when view disappears
        }
    }

    private func setupPlayer() {
        guard let url = URL(string: song.previewUrl ?? "") else { return }
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
    ItunesSongDetailView(song: iTunesSong(
        id: 1766137051,
        title: "The Emptiness Machine",
        artist: "LINKIN PARK",
        artworkUrl: "https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/69/21/cf/6921cff3-7074-118a-ece2-4012450e6c75/093624839811.jpg/100x100bb.jpg",
        trackViewUrl: "https://music.apple.com/us/album/the-emptiness-machine/1766137051?i=1766137052",
        previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview122/v4/53/43/1f/53431f46-36d0-1a69-5c9b-f8f5bf9d82a5/mzaf_13055374056954277786.plus.aac.p.m4a"
    ))
}
