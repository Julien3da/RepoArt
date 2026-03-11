//
//  HistoArtist.swift
//  GroupeArt
//
//  Created by FUVE on 10/03/2026.
//

import SwiftUI

struct HistoArtist: View {
    
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(mockArtists) { artist in
                            NavigationLink {
                                ArtistDetails(artist: artist)
                            } label: {
                                HistoArtistCard(artist: artist)
                            } .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    HistoArtist()
}
