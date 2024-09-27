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
    
    @Binding var isPlaying: Bool
    
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
                    NavigationLink(destination: SongDetailView(title: song.name, artist: song.artistName, artworkUrl: song.artworkUrl100, trackViewUrl: song.url, setCurrentSong: {})) {
                        SongListItemView(title: song.name, artist: song.artistName, artWork: song.artworkUrl100)
                    }
                }
                .navigationTitle("Top Songs")
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
    ChartView(isPlaying: .constant(false))
}
