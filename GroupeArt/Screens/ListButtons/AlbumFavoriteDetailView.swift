//
//  AlbumFavoriteDetailView.swift
//  GroupeArt
//
//  Created by Julien Estrada on 10/03/2026.
//

import SwiftUI

struct AlbumFavoriteDetailView: View {

    @State private var albumVM = AlbumViewModel()
    @State private var searchText = ""

    private var filteredAlbums: [Album] {
        guard !searchText.isEmpty else { return albumVM.albums }
        return albumVM.albums.filter {
            $0.albumTitle.localizedCaseInsensitiveContains(searchText) ||
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
                        RoundedRectangle(cornerRadius: 28)
                            .fill(Color.white.opacity(0.85))
                            .frame(width: 200, height: 200)
                            .shadow(color: .black.opacity(0.1), radius: 16, x: 0, y: 6)

                        Image(systemName: "menucard")
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

                    Text("Albums favoris")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(.bottom, 24)

                    if albumVM.albums.isEmpty {
                        ProgressView("Chargement…")
                            .padding(.top, 40)
                    } else {
                        VStack(spacing: 0) {
                            ForEach(Array(filteredAlbums.enumerated()), id: \.element.id) { index, album in
                                NavigationLink(destination: ContentView(specificAlbum: album)) {
                                VStack(spacing: 0) {
                                    HStack(spacing: 14) {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(album.albumTitle)
                                                .font(.system(size: 17, weight: .semibold))
                                                .foregroundColor(.primary)
                                            Text(album.artistName)
                                                .font(.system(size: 14))
                                                .foregroundColor(.secondary)
                                            if let year = album.yearRelease {
                                                Text(year)
                                                    .font(.system(size: 12))
                                                    .foregroundColor(.secondary)
                                            }
                                            HStack(spacing: 4) {
                                                Image(systemName: "star.fill")
                                                    .font(.system(size: 13))
                                                    .foregroundColor(.orangeArt)
                                                Text(String(format: "%.1f", album.globalReview))
                                                    .font(.system(size: 14, weight: .medium))
                                                    .foregroundColor(.orangeArt)
                                            }
                                        }

                                        Spacer()

                                        // Cover album depuis l'API
                                        if let urlString = album.coverURL, let url = URL(string: urlString) {
                                            AsyncImage(url: url) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                            } placeholder: {
                                                Color.gray.opacity(0.2)
                                                    .overlay(
                                                        Image(systemName: "music.note")
                                                            .foregroundColor(.gray)
                                                    )
                                            }
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(12)
                                        } else {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.gray.opacity(0.2))
                                                .frame(width: 60, height: 60)
                                                .overlay(
                                                    Image(systemName: "music.note")
                                                        .foregroundColor(.gray)
                                                )
                                        }

                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 14)

                                    if index < filteredAlbums.count - 1 {
                                        Divider()
                                            .padding(.horizontal, 20)
                                    }
                                }.contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 28)
                                .fill(Color.white.opacity(0.6))
                        )
                        .padding(.horizontal, 16)
                        .padding(.bottom, 30)
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Rechercher un album ou artiste")
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
        AlbumFavoriteDetailView()
    }
}
