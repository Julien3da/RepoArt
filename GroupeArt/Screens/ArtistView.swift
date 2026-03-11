//
//  ArtistView.swift
//  GroupeArt
//
//  Created by Julien Estrada on 11/03/2026.
//

import SwiftUI

struct ArtistView: View {
    let artist: Artist
    @State private var albumVM = AlbumViewModel()

    let backgroundGradient = LinearGradient(
        stops: [
            Gradient.Stop(color: .grisArt, location: 0.07),
            Gradient.Stop(color: .beigeArt, location: 0.66),
            Gradient.Stop(color: .orangeArt, location: 1.0)
        ],
        startPoint: .top,
        endPoint: .bottom
    )

    /// Albums de cet artiste
    private var artistAlbums: [Album] {
        albumVM.albums.filter { $0.artistName == artist.artistName }
    }

    var body: some View {
        ZStack {
            backgroundGradient.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {

                    // MARK: - Photo artiste
                    if let urlString = artist.pictureURL, let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                                .overlay(ProgressView())
                        }
                        .frame(width: 220, height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .shadow(color: .black.opacity(0.2), radius: 16, x: 0, y: 8)
                    } else {
                        RoundedRectangle(cornerRadius: 40)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 220, height: 220)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 70))
                                    .foregroundColor(.gray)
                            )
                    }

                    // MARK: - Nom
                    Text(artist.artistName)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.primary)

                    // MARK: - Description
                    if let desc = artist.artistDescription, !desc.isEmpty {
                        Text(desc)
                            .font(.system(size: 15))
                            .foregroundColor(.primary.opacity(0.85))
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.7))
                            )
                            .padding(.horizontal, 24)
                    }

                    // MARK: - Boutons
                    HStack(spacing: 14) {
                        Button {} label: {
                            Text("Partager")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .background(Color.noirArt)
                                .clipShape(Capsule())
                        }

                        Button {} label: {
                            HStack(spacing: 6) {
                                Text("Ajouter à une liste")
                                    .font(.system(size: 16, weight: .semibold))
                                Image(systemName: "text.badge.plus")
                            }
                            .foregroundColor(.noirArt)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(Color.orangeArt)
                            .clipShape(Capsule())
                        }
                    }
                    .padding(.horizontal, 24)

                    // MARK: - Albums
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Albums")
                            .font(.system(size: 26, weight: .bold))
                            .padding(.leading, 24)

                        if artistAlbums.isEmpty {
                            ProgressView("Chargement des albums…")
                                .padding(.top, 10)
                                .frame(maxWidth: .infinity)
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(artistAlbums) { album in
                                        NavigationLink(destination: ContentView(specificAlbum: album)) {
                                            VStack(spacing: 8) {
                                                if let urlString = album.coverURL, let url = URL(string: urlString) {
                                                    AsyncImage(url: url) { image in
                                                        image
                                                            .resizable()
                                                            .scaledToFill()
                                                    } placeholder: {
                                                        Color.gray.opacity(0.2)
                                                            .overlay(ProgressView())
                                                    }
                                                    .frame(width: 130, height: 130)
                                                    .clipShape(RoundedRectangle(cornerRadius: 18))
                                                } else {
                                                    RoundedRectangle(cornerRadius: 18)
                                                        .fill(Color.gray.opacity(0.2))
                                                        .frame(width: 130, height: 130)
                                                        .overlay(
                                                            Image(systemName: "music.note")
                                                                .font(.system(size: 30))
                                                                .foregroundColor(.gray)
                                                        )
                                                }

                                                Text(album.albumTitle)
                                                    .font(.system(size: 14, weight: .medium))
                                                    .foregroundColor(.primary)
                                                    .lineLimit(1)
                                                    .frame(width: 130)
                                            }
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                                .padding(.horizontal, 24)
                            }
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 30)
                }
                .padding(.top, 24)
            }
        }
        .navigationTitle(artist.artistName)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            do {
                _ = try await albumVM.fetchAlbums()
            } catch {
                print("Erreur chargement albums: \(error)")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ArtistView(artist: Artist(artistName: "SZA", artistDescription: "Chanteuse américaine de R&B alternatif reconnue pour ses textes introspectifs et sa voix unique."))
    }
}
