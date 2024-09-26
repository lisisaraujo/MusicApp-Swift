//
//  ItunesSongListItemView.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 25.09.24.
//

import SwiftUI

struct ItunesSongListItemView: View {
    var song: iTunesSong
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: song.artworkUrl!)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                //        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 4)
      
                case .failure:
                    Image(systemName: "photo") // Placeholder image in case of failure
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 4)
                case .empty:
                    ProgressView() // Loading indicator while the image is being fetched
                        .frame(width: 80, height: 80)
                @unknown default:
                    EmptyView() // Fallback for future cases
                }
            }
            
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
    ItunesSongListItemView(song: iTunesSong(
        id: 1766137051,
        title: "The Emptiness Machine",
        artist: "LINKIN PARK",
        artworkUrl: "https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/69/21/cf/6921cff3-7074-118a-ece2-4012450e6c75/093624839811.jpg/100x100bb.jpg",
        trackViewUrl: "https://music.apple.com/us/album/the-emptiness-machine/1766137051?i=1766137052", previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview122/v4/53/43/1f/53431f46-36d0-1a69-5c9b-f8f5bf9d82a5/mzaf_13055374056954277786.plus.aac.p.m4a"
    ))
}
