//
//  SongListItemView.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 23.09.24.
//

import SwiftUI

struct SongListItemView: View {
    
    var title: String?
    var artist: String?
    var artWork: String?
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: artWork ?? "" )) { phase in
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
                Text(title ?? "")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(artist ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 10)
        }
        .padding()
    }
}

#Preview {
   SongListItemView()
}
