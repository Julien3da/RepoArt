//
//  ArtistDetails.swift
//  GroupeArt
//
//  Created by BlueOneThree on 10/03/2026.
//

import SwiftUI

struct ArtistDetails: View {
    let artist: LastFmArtistInfo
    
    let backgroundGradient = LinearGradient(
        stops: [
            Gradient.Stop(color: .grisArt, location: 0.07),
            Gradient.Stop(color: .beigeArt, location: 0.66),
            Gradient.Stop(color: .orangeArt, location: 1.0)
        ],
        startPoint: .top,
        endPoint: .bottom
    )

    var placeholderArtist: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.orangeArt.opacity(0.2))
                .frame(width: 300, height: 300)
            Image(systemName: "eye.fill")
                .font(.system(size: 80))
                .foregroundStyle(.orangeArt)
        }
    }

    var body: some View {
        ZStack {
            // Fond flouté
            if let imageURL = artist.wikipediaImageURL {
                AsyncImage(url: imageURL) { phase in
                    if case .success(let image) = phase {
                        image
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .blur(radius: 30)
                    }
                }
            } else {
                backgroundGradient.ignoresSafeArea()
            }

            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // Bloc image + nom
                    VStack {
                        if let imageURL = artist.wikipediaImageURL {
                            AsyncImage(url: imageURL) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 300, height: 300)
                                        .cornerRadius(18)
                                default:
                                    placeholderArtist
                                }
                            }
                        } else {
                            placeholderArtist
                        }

                        Text(artist.name)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .frame(width: 325, height: 368)
                    .glassEffect(in: .rect(cornerRadius: 28.0))
                    .padding()

                    // Bio
                    if let bio = artist.wikipediaBio, !bio.isEmpty {
                        ExpandableText(text: bio)
                            .frame(width: 325)
                            .padding(.horizontal)
                    } else {
                        ExpandableText(text: "Pas disponible pour le moment.")
                            .frame(width: 325)
                            .padding(.horizontal)
                    }

                    // Bouton Last.fm
                    LastFmButton(url: artist.url)
                        .padding(.top)
                }
            }
        }
    }
}

#Preview {
    ArtistDetails(artist: LastFmArtistInfo(
        name: "Daft Punk",
        url: "https://www.last.fm/music/Daft+Punk",
        image: [LastFmImage(text: "https://lastfm.freetls.fastly.net/i/u/300x300/placeholder.jpg", size: "extralarge")],
        bio: LastFmBio(summary: "Duo électronique français légendaire.")
    ))
}
