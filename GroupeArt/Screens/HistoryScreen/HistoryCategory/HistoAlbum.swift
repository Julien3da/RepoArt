//
//  HistoAlbum.swift
//  GroupeArt
//
//  Created by FUVE on 10/03/2026.
//

import SwiftUI

struct HistoAlbum: View {
    
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            
              
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(mockAlbums) { album in
                            NavigationLink {
                                AlbumDetails(album: album)
                            } label: {
                                HistoAlbumCard(album: album)
                            } .buttonStyle(.plain)
                        }
                    }
                    .padding()
                
        }
    }
}

#Preview {
    HistoAlbum()
}

