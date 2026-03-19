//
//  PostReviewV.swift
//  GroupeArt
//
//  Created by BlueOneThree on 13/03/2026.
//

import SwiftUI

import SwiftUI

struct PostReviewV: View {
    let album: Album
    var onReviewPosted: ((Int) -> Void)? = nil
    @State private var showSheet = true
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            if let background = album.coverURL, let url = URL(string: background) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .scaleEffect(1.05)
                        .ignoresSafeArea()
                        .blur(radius: 30)
                } placeholder: {
                    Color.clear.opacity(0.3)
                        .overlay(ProgressView("Chargement"))
                }
            }

            VStack {
                if let header = album.coverURL, let url = URL(string: header) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .scaleEffect(1.05)
                    } placeholder: { }
                    .frame(width: 402, height: 261)
                    .ignoresSafeArea(edges: .top)
                    .mask(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .black, location: 0),
                                .init(color: .black, location: 0.6),
                                .init(color: .clear, location: 1)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .ignoresSafeArea(edges: .top)
                    )
                }
                Spacer()
                
            }
            .sheet(isPresented: $showSheet) {
                ScrollView {
                    VStack(spacing: 16) {
                        ARExpandTitle(album: album)
                        ReviewCard(album: album, onReviewPosted: onReviewPosted)
                    }
                    .padding(.top, 18)
                    .padding(.horizontal)
                    .padding(.bottom, 32)
                }
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
                .presentationBackground {
                    if let urlString = album.coverURL, let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .blur(radius: 40)
                                .overlay(Color.black.opacity(0.3))
                        } placeholder: {
                            Color.gray
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}
