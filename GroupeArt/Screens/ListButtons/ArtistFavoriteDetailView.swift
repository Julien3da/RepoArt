//
//  ArtistFavoriteDetailView.swift
//  GroupeArt
//
//  Created by Julien Estrada on 11/03/2026.
//

import SwiftUI

struct ArtistFavoriteDetailView: View {

    @State private var artistVM = ArtistViewModel()
    @State private var searchText = ""

    private var filteredArtists: [Artist] {
        guard !searchText.isEmpty else { return artistVM.artists }
        return artistVM.artists.filter {
            $0.artistName.localizedCaseInsensitiveContains(searchText)
        }
    }

    let backgroundGradient = LinearGradient(
        stops: [
            Gradient.Stop(color: .grisArt, location: 0.07),
            Gradient.Stop(color: .beigeArt, location: 0.66),
            Gradient.Stop(color: .orangeArt, location: 1.0)
        ],
        startPoint: .top,
        endPoint: .bottom
    )

    var body: some View {
        ZStack {
            backgroundGradient.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 32)
                            .fill(Color.white.opacity(0.85))
                            .frame(width: 200, height: 200)
                            .shadow(color: .black.opacity(0.1), radius: 16, x: 0, y: 6)

                        Image(systemName: "music.microphone")
                            .font(.system(size: 90, weight: .regular))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.orangeArt, .orangeArt.opacity(0.5)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }
                    .padding(.top, 24)
                    .padding(.bottom, 16)

                    Text("Artistes favoris")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(.bottom, 24)

                    if artistVM.artists.isEmpty {
                        ProgressView("Chargement…")
                            .padding(.top, 40)
                    } else {
                        VStack(spacing: 0) {
                            ForEach(Array(filteredArtists.enumerated()), id: \.element.id) { index, artist in
                                NavigationLink(destination: ArtistView(artist: artist)) {
                                VStack(spacing: 0) {
                                    HStack(spacing: 14) {
                                        // Photo artiste depuis l'API
                                        if let urlString = artist.pictureURL, let url = URL(string: urlString) {
                                            AsyncImage(url: url) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                            } placeholder: {
                                                Color.gray.opacity(0.2)
                                                    .overlay(
                                                        Image(systemName: "person.fill")
                                                            .font(.system(size: 24))
                                                            .foregroundColor(.gray)
                                                    )
                                            }
                                            .frame(width: 56, height: 56)
                                            .clipShape(Circle())
                                        } else {
                                            Circle()
                                                .fill(Color.gray.opacity(0.2))
                                                .frame(width: 56, height: 56)
                                                .overlay(
                                                    Image(systemName: "person.fill")
                                                        .font(.system(size: 24))
                                                        .foregroundColor(.gray)
                                                )
                                        }

                                        Text(artist.artistName)
                                            .font(.system(size: 17, weight: .semibold))
                                            .foregroundColor(.primary)

                                        Spacer()

                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 12)

                                    if index < filteredArtists.count - 1 {
                                        Divider()
                                            .padding(.horizontal, 20)
                                    }
                                }
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.6))
                        )
                        .padding(.horizontal, 16)
                        .padding(.bottom, 30)
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Rechercher un artiste")
        .task {
            do {
                _ = try await artistVM.fetchArtists()
            } catch {
                print("Erreur chargement artistes: \(error)")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ArtistFavoriteDetailView()
    }
}
