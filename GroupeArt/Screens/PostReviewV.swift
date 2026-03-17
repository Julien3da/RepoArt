////
////  PostReviewV.swift
////  GroupeArt
////
////  Created by apprenant84 on 16/03/2026.
////
//
//import SwiftUI
//
//struct PostReviewV: View {
//    let album : Album
//    @State private var showSheet = true
//    
//    var body: some View {
//        ZStack {
//            // Background Album Cover
//            if let background = album.coverURL, let url = URL(string: background) {
//                AsyncImage(url: url) { image in image
//                        .resizable()
//                        .scaledToFill()
//                        .scaleEffect(1.05)
//                        .ignoresSafeArea()
//                        .blur(radius: 30)
//                } placeholder: {
//                    Color.clear.opacity(0.3)
//                        .overlay(ProgressView("Chargement"))
//                }
//            }
//            
////            // Header Album Cover
////            VStack {
////                if let header = album.coverURL, let url = URL(string: header) {
////                    AsyncImage(url: url) { image in
////                        image
////                            .resizable()
////                            .scaledToFill()
////                            .scaleEffect(1.05)
////                    } placeholder: { }
////                    .frame(width: 402, height: 261)
////                    .ignoresSafeArea(edges: .top)
////                    .mask(
////                        LinearGradient(
////                            gradient: Gradient(stops: [
////                                .init(color: .black, location: 0),
////                                .init(color: .black, location: 0.6),
////                                .init(color: .clear, location: 1)
////                            ]),
////                            startPoint: .top,
////                            endPoint: .bottom
////                        )
////                        .ignoresSafeArea(edges: .top)
////                    )
////                }
////                Spacer()
////            }
////            // Bottom Sheet
////            .sheet(isPresented: $showSheet) {
////                ScrollView {
////                    VStack(spacing: 16) {
////                        ARExpandTitle(album: album)
////                        ReviewCard(album: album)
////                    }
////                    .padding(.top, 18)
////                    .padding(.horizontal)
////                    .padding(.bottom, 32)
////                }
////                .presentationDetents([.medium, .large])
////                .presentationDragIndicator(.visible)
////                .interactiveDismissDisabled() // empêche de fermer complètement
////                .presentationBackground {
////                    // Album cover comme background du sheet
////                    if let urlString = album.coverURL, let url = URL(string: urlString) {
////                        AsyncImage(url: url) { image in
////                            image
////                                .resizable()
////                                .scaledToFill()
////                                .blur(radius: 40)
////                                .overlay(Color.black.opacity(0.3))
////                        } placeholder: {
////                            Color.gray
////                        }
////                    }
////                }
////            }
////            ARCard(album: .mock), plus utile
//        }
//    }
//}
//
//#Preview {
//    PostReviewV(album: FakeAlbum[0])
//}
