//
//  HistoArtistCard.swift
//  GroupeArt
//
//  Created by BlueOneThree on 11/03/2026.
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
                .resizable()
                .scaledToFill()
                .frame(width: 28, height: 28)
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
                            .frame(width: 148, height: 148)
                            .cornerRadius(14)
                            .padding()
                    default:
                        placeholderImage.overlay(ProgressView())
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
        .glassEffect(in: .rect(cornerRadius: 28.0))
//        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    HistoArtistCard(artist: LastFmArtistInfo(
        name: "Brent Faiyaz",
        url: "https://www.last.fm/music/Daft+Punk",
        image: [LastFmImage(text: "https://upload.wikimedia.org/wikipedia/commons/a/a1/Brent_Faiyaz.jpg", size: "extralarge")],
        bio: LastFmBio(summary: "Chanteur R&B américain.")
    ))
}
