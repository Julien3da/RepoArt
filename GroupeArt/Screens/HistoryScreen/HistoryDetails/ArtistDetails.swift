//
//  ArtistDetails.swift
//  GroupeArt
//
//  Created by FUVE on 10/03/2026.
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

                    // Bio
                    if let bio = artist.wikipediaBio, !bio.isEmpty {
                        ExpandableText(text: bio)
                            .frame(width: 325)
                            .padding(.horizontal)
                    } else {
                        ExpandableText(text: "Écoutez mes chansons pour m'aider à me faire connaître :).")
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
