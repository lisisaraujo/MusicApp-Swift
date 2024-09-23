//
//  HomeView.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 23.09.24.
//

import SwiftUI
import SwiftData

struct ChartView: View {
    
    var body: some View {
        NavigationStack{
            List(songs){song in
                NavigationLink(destination: SongView()) {
                    SongListItemView(song: song)
                }
            }.navigationTitle("Top Songs")
        }
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Song.self, configurations: configuration)
    
    return ChartView()
        .modelContainer(container)
}
