//
//  SearchView.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 24.09.24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var songsList: [Song2] = []
    @State private var errorMessage: String?
    

    var body: some View {
        NavigationStack {
            VStack {
                // search Field
                TextField("Enter song title or artist", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: searchText) { newValue in
                        Task {
                            await fetchSongs()
                        }
                    }
                
                // display error message if any
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                List(songsList) { song in
                         NavigationLink(destination: ItunesSongDetailView(song: song)) {
                             ItunesSongListItemView(song: song)
                         }
                     }
                 }
                 .navigationTitle("Search Songs")
        }
    }

    private func fetchSongs() async {
        guard !searchText.isEmpty else {
            songsList = []
            return
        }

        let formattedQuery = searchText.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://itunes.apple.com/search?term=\(formattedQuery)&entity=song"

        do {
            let songs = try await getSongs(from: urlString)
            self.songsList = songs
            self.errorMessage = nil // clear any previous error messages
        } catch {
            self.errorMessage = (error as? HTTPError)?.message ?? "An unexpected error occurred."
            print("Error fetching songs:", error)
        }
    }

    private func getSongs(from urlString: String) async throws -> [Song2] {
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ItunesResponse.self, from: data)
        return response.results
    }
}

#Preview {
    SearchView()
}
