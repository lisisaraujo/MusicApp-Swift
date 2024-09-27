//
//  SearchView.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 24.09.24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var songsList: [iTunesSong] = []
    @State private var errorMessage: String?
    
    @Binding var currentSong: iTunesSong?
    

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
                    NavigationLink(destination: SongDetailView(title: song.title, artist: song.artist, artworkUrl: song.artworkUrl, previewUrl: song.previewUrl, trackViewUrl: song.trackViewUrl, setCurrentSong: {
                        currentSong = song
                    })) {
                        SongListItemView(title: song.artist, artist: song.artist, artWork: song.artworkUrl)
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

    private func getSongs(from urlString: String) async throws -> [iTunesSong] {
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ItunesResponse.self, from: data)
        return response.results
    }
}

#Preview {
    SearchView(currentSong: .constant(iTunesSong(
        id: 1766137051,
        title: "The Emptiness Machine",
        artist: "LINKIN PARK",
        artworkUrl: "https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/69/21/cf/6921cff3-7074-118a-ece2-4012450e6c75/093624839811.jpg/100x100bb.jpg",
        trackViewUrl: "https://music.apple.com/us/album/the-emptiness-machine/1766137051?i=1766137052",
        previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview122/v4/53/43/1f/53431f46-36d0-1a69-5c9b-f8f5bf9d82a5/mzaf_13055374056954277786.plus.aac.p.m4a"
    )))
}
