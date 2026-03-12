//
//  HistoAlbumCard.swift
//  GroupeArt
//
//  Created by FUVE on 11/03/2026.
//

import SwiftUI

struct HistoAlbumCard: View {
    let album : Album
    
    var body: some View {
        VStack {
            Image(album.albumCover)
                .resizable()
                .scaledToFill()
                .frame(width: 144, height: 144)
                .cornerRadius(14)
            Text(album.albumTitle)
                .font(.body)
                .fontWeight(.semibold)
            Text(album.artist.artistName)
                .font(.body)
                .fontWeight(.thin)
        }
        .frame(width: 174, height: 230)
        //EFFET LIQUID GLASS
        .background(
            ZStack {
                // Le matériau flou (Glassmorphism)
                RoundedRectangle(cornerRadius: 28)
                    .fill(.ultraThinMaterial)
                
                // fine bordure brillante pour accentuer l'effet "verre"
                RoundedRectangle(cornerRadius: 28)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            }
        )
        .background(Color.grisArt.opacity(0.1))
        .cornerRadius(28)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    HistoAlbumCard(album: .mock)
}
