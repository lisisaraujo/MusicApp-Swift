//
//  SongListItemView.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 23.09.24.
//

import SwiftUI

struct SongListItemView: View {
    
    var song: TopSong
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: song.artworkUrl100)) { phase in
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
                Text(song.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(song.artistName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 10)
        }
        .padding()
    }
}

#Preview {
   SongListItemView(song: TopSong(id: "1766137051", name: "The Emptiness Machine", artistName: "LINKIN PARK", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/69/21/cf/6921cff3-7074-118a-ece2-4012450e6c75/093624839811.jpg/100x100bb.jpg", url: "#"))
}
