//
//  PostReview.swift
//  GroupeArt
//
//  Created by BlueOneThree on 13/03/2026.
//

import SwiftUI

struct ReviewCard: View {
    let album: Album
    var onReviewPosted: ((Int) -> Void)? = nil
    @State private var mark: Int = 0
    @State private var reviewTitle: String = ""
    @State private var reviewText: String = ""
    @State private var viewModel = ReviewViewModel()

    private var canPost: Bool {
        mark > 0 && !reviewTitle.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Notez l'album")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .center)

            // Étoiles
            HStack {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= mark ? "star.fill" : "star")
                        .foregroundStyle(.orangeArt)
                        .font(.title2)
                        .onTapGesture { mark = index }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)

            Divider()

            // Titre (obligatoire)
            TextField("Ton avis en quelques mots...", text: $reviewTitle)
                .fontWeight(.semibold)

            Divider()

            // Avis texte (facultatif) + bouton envoyer
            HStack(alignment: .bottom) {
                TextField("Développe ton avis", text: $reviewText, axis: .vertical)
                    .lineLimit(3...6)

                if canPost {
                    Button {
                        Task {
                            let postedMark = mark
                            await viewModel.postReview(
                                album: album,
                                mark: mark,
                                reviewTitle: reviewTitle,
                                reviewText: reviewText.isEmpty ? nil : reviewText
                            )
                            if viewModel.success {
                                onReviewPosted?(postedMark)
                            }
                            reviewTitle = ""
                            reviewText = ""
                            mark = 0
                        }
                    } label: {
                        if viewModel.isPosting {
                            ProgressView()
                        } else {
                            Image(systemName: "paperplane.fill")
                                .foregroundStyle(.orangeArt)
                        }
                    }
                }
            }
        }
        .padding()
        .glassEffect(in: .rect(cornerRadius: 28.0))
        .frame(width: 378)
    }
}
