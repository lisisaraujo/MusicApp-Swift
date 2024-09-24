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
    
    
    var body: some View {
        VStack{
           
            TabView(selection: $selectedTab) {
                ChartView()
                    .tabItem {
                        Label("Music", systemImage: "music.note")
                    }.tag(Tab.chart)

                SearchView()
                  .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                  }.tag(Tab.search)

             
            }
        }
  
    }
}

#Preview {
    HomeView()
}
