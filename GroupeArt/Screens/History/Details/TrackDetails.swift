//
//  TrackDetails.swift
//  GroupeArt
//
//  Created by FUVE on 10/03/2026.
//

import SwiftUI

struct TrackDetails: View {
    let track : Track
    
    var body: some View {
        ZStack {
            Image(track.albumCover)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 30)
            VStack {
                VStack {
                    Image(track.albumCover)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                        .cornerRadius(18)
                    
                    Text(track.trackTitle)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(track.trackArtist.artistName)
                        .font(.title2)
                    
                }
                .frame(width: 325, height: 403)
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
                    .padding()
                AppleMusicButton()
                    .padding()
                SpotifyButton()
            }
        }
    }
}

#Preview {
    TrackDetails(track: mockTracks[0])
}
