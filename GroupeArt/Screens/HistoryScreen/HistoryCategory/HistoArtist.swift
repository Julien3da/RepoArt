//
//  HistoArtist.swift
//  GroupeArt
//
//  Created by BlueOneThree on 10/03/2026.
//

import SwiftUI

struct HistoArtist: View {
    @State private var viewModel = LastFmArtistViewModel()

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(viewModel.artists) { artist in
                NavigationLink {
                    ArtistDetails(artist: artist)
                } label: {
                    HistoArtistCard(artist: artist)
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .task {
            await viewModel.getRecentArtists()
        }
    }
}

#Preview {
    HistoArtist()
}

