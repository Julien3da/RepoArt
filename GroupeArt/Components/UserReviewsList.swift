//
//  UserReviewsList.swift
//  GroupeArt
//
//  Created by BlueOneThree on 16/03/2026.
//

import SwiftUI

struct UserReviewsList: View {
    let userId: String  // le recordId Airtable de l'utilisateur
    
    @State private var viewModel = ReviewViewModel()
    @State private var isLoading = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Mes reviews")
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else if viewModel.reviews.isEmpty {
                Text("Aucune review pour l'instant.")
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
            } else {
                ForEach(viewModel.reviews) { review in
                    UserReviewRow(review: review, album: .mock)
                }
            }
        }
        .task {
            isLoading = true
            do {
                _ = try await viewModel.fetchReviews(forUserId: userId)
            } catch {
                // Optionally, handle/log error
            }
            isLoading = false
        }
    }
}

struct UserReviewRow: View {
    let review: Review
    let album: Album

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Left content
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

            // Album cover
            if let coverURL = album.coverURL, let url = URL(string: coverURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.gray.opacity(0.3))
                }
                .frame(width: 90, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding()
        .frame(width: 370, height: 152)
        .glassEffect(in: .rect(cornerRadius: 28))
    }
}

#Preview {
    UserReviewsList(userId: "recwAC44d2sQ2kwql")
}
