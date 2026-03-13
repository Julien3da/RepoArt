////
////  HistoAlbum.swift
////  GroupeArt
////
////  Created by FUVE on 11/03/2026.
////
//
//<<<<<<< HEAD:GroupeArt/Components/History/HistoAlbumCard.swift
////import SwiftUI
////
////struct HistoAlbumCard: View {
////    let album : Album
////    
////    var body: some View {
////    }
////}
////
////#Preview {
////    HistoAlbumCard(album: Albums[0])
////}
//=======
//import SwiftUI
//
//  Created by FUVE on 10/03/2026.
//

import SwiftUI

struct HistoTrack: View {
    @State private var viewModel = LastFmViewModel()

    

    var body: some View {
        VStack{
            ForEach(viewModel.tracks) { track in
                NavigationLink {
                    TrackDetails(track: track)
                } label: {
                    HistoTrackCard(track: track)
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .task {
            await viewModel.getRecentTracks()
        }
    }
}

#Preview {
    HistoTrack()
}

