//
//  HistoArtistCard.swift
//  GroupeArt
//
//  Created by FUVE on 11/03/2026.
//

import SwiftUI

struct HistoArtistCard: View {
    let artist: LastFmArtistInfo
    
    var placeholderImage: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.orangeArt.opacity(0.2))
                .frame(width: 144, height: 144)
            Image(systemName: "eye.fill")
                .font(.system(size: 40))
                .foregroundStyle(.orangeArt)
        }
        .padding()
    }
    
    var body: some View {
        VStack {
            if let imageURL = artist.wikipediaImageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 144, height: 144)
                            .cornerRadius(14)
                            .padding()
                    default:
                        placeholderImage
                    }
                }
            } else {
                placeholderImage
            }
            Text(artist.name)
                .font(.body)
                .fontWeight(.semibold)
                .lineLimit(1)
        }
        .frame(width: 174, height: 230)
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
    }
}

#Preview {
    HistoArtistCard(artist: LastFmArtistInfo(
        name: "Daft Punk",
        url: "https://www.last.fm/music/Daft+Punk",
        image: [LastFmImage(text: "https://lastfm.freetls.fastly.net/i/u/300x300/placeholder.jpg", size: "extralarge")],
        bio: LastFmBio(summary: "Duo électronique français légendaire.")
    ))
}
