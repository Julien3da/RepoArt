//
//  AlbumDetails.swift
//  GroupeArt
//
//  Created by FUVE on 10/03/2026.
//

import SwiftUI

struct AlbumDetails: View {
    let album : Album
    
    var body: some View {
        ZStack {
            Image(album.albumCover)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(maxWidth : .infinity, maxHeight: .infinity)
                .blur(radius: 30)
            VStack {
                VStack {
                    Image(album.albumCover)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                        .cornerRadius(18)
                    
                    Text(album.albumTitle)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(album.artist.artistName)
                        .font(.title2)
                    
                }
                .frame(width: 325, height: 403)
                //EFFET LIQUID GLASS
                .background(
                    ZStack {
                        // Le matériau flou (Glassmorphism)
                        RoundedRectangle(cornerRadius: 28)
                            .fill(.ultraThinMaterial)
                        
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    }
                )
                .background(Color.grisArt.opacity(0.1))
                .cornerRadius(28)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                // Boutons Apple Music / Spotify
                    .padding()
                AppleMusicButton()
                    .padding()
                SpotifyButton()
            }
        }
    }
}

#Preview {
    AlbumDetails(album: mockAlbums[0])
}
