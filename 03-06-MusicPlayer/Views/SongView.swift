//
//  SongView.swift
//  03-06-MusicPlayer
//
//  Created by Lisis Ruschel on 23.09.24.
//

import SwiftUI

struct SongView: View {
    @State var song: Song
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SongView(song: (Song(id: "1766137051", name: "The Emptiness Machine", artistName: "LINKIN PARK", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/69/21/cf/6921cff3-7074-118a-ece2-4012450e6c75/093624839811.jpg/100x100bb.jpg", url: "#")))
}
