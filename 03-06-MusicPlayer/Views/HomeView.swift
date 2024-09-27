//
//  HomeView.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 24.09.24.
//

import SwiftUI

enum Tab {
    case chart, search
}

struct HomeView: View {
    @State var selectedTab: Tab = .chart
    @State var currentSong: iTunesSong?
    
    @State var isPlaying = false
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    ChartView(isPlaying: $isPlaying)
                        .tabItem {
                            Label("Charts", systemImage: "chart.bar.fill")
                        }.tag(Tab.chart)
                    
                    SearchView(currentSong: $currentSong)
                        .tabItem {
                            Label("Search", systemImage: "magnifyingglass")
                        }.tag(Tab.search)
                }
            }
            VStack(spacing: 0){
                Spacer()
                if currentSong != nil {
                MiniPlayerView(currentSong: $currentSong)
                        .padding(.vertical, 49)
                }
            }
        
        }
    }
}

#Preview {
    HomeView()
}
