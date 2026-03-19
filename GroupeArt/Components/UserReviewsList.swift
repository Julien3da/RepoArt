//
//  UserReviewsList.swift
//  GroupeArt
//
//  Created by BlueOneThree on 16/03/2026.
//

import SwiftUI

struct UserReviewsList: View {
    let username: String

    @State private var reviewVM = ReviewViewModel()
    @State private var albumVM = AlbumViewModel()
    @State private var albumsById: [String: Album] = [:]
    @State private var isLoading = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else if reviewVM.reviews.isEmpty {
                Text("Aucune review pour l'instant.")
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
            } else {
                ForEach(reviewVM.reviews) { review in
                    if let albumId = review.album?.first,
                       let album = albumsById[albumId] {
                        UserReviewRow(review: review, album: album)
                    }
                }
            }
        }
        .onAppear {
            print("🔵 onAppear appelé - isLoading: \(isLoading)")
            Task {
                guard !isLoading else { return }
                isLoading = true
                reviewVM.reviews = []
                albumsById = [:]
                do {
                    // ✅ séquentiel au lieu de parallèle
                    let reviews = try await reviewVM.fetchUserReviews(forUsername: username)
                    let albums = try await albumVM.fetchAlbums()
                    albumsById = Dictionary(uniqueKeysWithValues: albums.compactMap { album in
                        guard let id = album.recordID else { return nil }
                        return (id, album)
                    })
                    print("✅ \(reviews.count) reviews, \(albums.count) albums")
                } catch {
                    print("❌ Erreur: \(error)")
                }
                isLoading = false
            }
        }
    }
}

struct UserReviewRow: View {
    let review: Review
    let album: Album

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text(album.albumTitle)
                    .fontWeight(.bold)
                    .font(.title3)

                Text(album.artistName)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)

                if let text = review.userReview {
                    Text("\"\(text)\"")
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                        .lineLimit(2)
                }

                Spacer()

                if let mark = review.markReview {
                    HStack(spacing: 4) {
                        Text(String(format: "%.1f", Double(mark)))
                            .fontWeight(.semibold)
                        Image(systemName: "star.fill")
                            .foregroundStyle(.orangeArt)
                            .font(.caption)
                    }
                }
            }

            Spacer()

            if let coverURL = album.coverURL, let url = URL(string: coverURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.gray.opacity(0.3))
                }
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding()
        .frame(width: 370, height: 152)
        .glassEffect(in: .rect(cornerRadius: 28))
    }
}

#Preview {
    UserReviewsList(username: "julien.serdaigle")
}
