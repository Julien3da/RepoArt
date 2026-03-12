//
//  ArtistDetails.swift
//  GroupeArt
//
//  Created by FUVE on 10/03/2026.
//

import SwiftUI

struct ArtistDetails: View {
    let artist: FakeArtist
    
    var body: some View {
        ZStack {
            Image(artist.artistPicture)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(maxWidth : .infinity, maxHeight: .infinity)
                .blur(radius:30)
            
            ScrollView (showsIndicators: false){
                VStack(spacing: 20) {
                    // Bloc image + nom de l'artiste
                    VStack {
                        Image(artist.artistPicture)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .cornerRadius(18)
                        
                        Text(artist.artistName)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .frame(width: 325, height: 368)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 28)
                                .fill(.ultraThinMaterial)
                            RoundedRectangle(cornerRadius: 28)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        }
                    )
                    .background(Color.grisArt.opacity(0.1))
                    .cornerRadius(28)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .padding()
                    
                    // Bloc biographie
                    ExpandableText(text: artist.artistDescription)
                        .frame(width: 325)
                    
                    // Boutons Apple Music / Spotify
                    AppleMusicButton()
                        .padding(.top)
                    SpotifyButton()
                }
                
            }.frame(width: UIScreen.main.bounds.width)
                .scrollContentBackground(.hidden)
                .toolbarBackground(.hidden, for: .navigationBar)
                .toolbarBackground(Color.clear, for: .navigationBar)
                .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    ArtistDetails(artist: mockArtists[6])
}

