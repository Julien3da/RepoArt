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

