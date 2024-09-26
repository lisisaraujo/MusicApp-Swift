//
//  HomeView.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 23.09.24.
//

import SwiftUI

struct ChartView: View {
    
    @State private var songsList: [TopSong] = []
    @State private var selectedCountry: SelectedCountry = .germany
    @State private var currentSong: TopSong? = TopSong(id: "1766137051", name: "The Emptiness Machine", artistName: "LINKIN PARK", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/69/21/cf/6921cff3-7074-118a-ece2-4012450e6c75/093624839811.jpg/100x100bb.jpg", url: "#")
    
    enum SelectedCountry: String, CaseIterable {
        case germany = "de"
        case us = "us"
        case uk = "gb"
        case japan = "jp"
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Picker("Select Country", selection: $selectedCountry) {
                        ForEach(SelectedCountry.allCases, id: \.self) { country in
                            Text(country.rawValue).tag(country)
                        }
                    }
                    .pickerStyle(.menu)
                    .padding(.horizontal)
                    .cornerRadius(10)
                    .padding(.top)
                }
              

                List(songsList) { song in
                    NavigationLink(destination: SongDetailView(topSong: song)) {
                        SongListItemView(song: song)
                    }
                }
                .navigationTitle("Top Songs")
                MiniPlayerView(currentSong: $currentSong)
            }
            .onAppear {
                fetchAPIData()
            }
            .onChange(of: selectedCountry) { newValue in
                fetchAPIData()
            }
        }
    }
    
    private func fetchAPIData() {
        Task {
            do {
                songsList = try await getSongs(countryCode: selectedCountry.rawValue)
                print(songsList)
            } catch let error as HTTPError {
                print(error.message)
            } catch {
                print(error)
            }
        }
    }
    
//    private func fetchData() {
//        let fetchedSongs = LocalDataService.shared.fetchAllSongs(for: selectedCountry.rawValue.lowercased())
//        
//        if fetchedSongs.isEmpty {
//            print("No songs found.")
//        } else {
//            print("Loaded \(fetchedSongs.count) songs.")
//        }
//        
//        songsList = fetchedSongs
//    }

}

#Preview {
    ChartView()
}
