//
//  FeedCardView.swift
//  GroupeArt
//
//  Created by apprenant92 on 10/03/2026.
//

import SwiftUI

struct FeedCardView: View {
    let review: Review
    let album: Album?
    let track: Track?

    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.grisArt)
                .glassEffect(.regular.tint(Color.grisArt), in: RoundedRectangle(cornerRadius: 24))
                .frame(height: 220)
                .frame(maxWidth: .infinity)
                .shadow(color: .black.opacity(0.12), radius: 10, x: 0, y: 4)
                .padding(.vertical, 3)
            
            VStack(alignment: .leading) {
                
                HStack(alignment: .top) {
                    
                    VStack(alignment: .leading) {
                        
                        if let album {
                            Text(album.albumTitle)
                                .font(.title3)
                                .bold()

                            Text(album.artistName)
                                .font(.subheadline)
                        }

                        if let track {
                            Text(track.trackTitle)
                                .font(.title3)
                                .bold()

                            Text(track.artistName)
                                .font(.subheadline)
                        }
                        
                        Text(review.reviewTitle ?? "Aucun titre")
                            .frame(width: 230, alignment: .leading)
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.bottom, 4)
                            .lineLimit(3)
                        
                                                
                        Text(review.userReview ?? "Aucun commentaire")
                            .frame(width: 230, alignment: .leading)
                            .font(.caption)
                            .padding(.bottom, 4)
                            .lineLimit(3)
                        
                        HStack (spacing: 2) {
                            
                            Image(systemName: "star.fill")
                                .font(.subheadline)
                                .padding(.bottom, 4)
                                .foregroundStyle(Color.orange)
                            
                            Text("\(review.markReview ?? 0)/5")
                                .font(.subheadline)
                                .padding(.bottom, 4)
                        }
                        
                        Text("De \(review.username)")
                            .font(.caption)
                            .bold()
                        
                        
                    }
                    .padding(.leading)
                    
                    VStack {
                        
                        HStack {
                            Spacer()
                            
                            let cover = album?.coverURL ?? track?.coverURL
                            
                            if let cover,
                               let url = URL(string: cover) {

                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.trailing, 18)

                            } else {

                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 100, height: 100)
                                    .foregroundStyle(Color.gray)
                                    .padding(.trailing, 18)

                            }
                        }
                        
                        HStack {
                            Spacer()
                            Button {
                            } label: {
                                Image(systemName: "chevron.right")
                                    .frame(width: 12, height: 12)
                                    .foregroundStyle(Color.black)
                                    .font(.system(size: 12))
                                    .bold()
                                    .padding(12)
                            }
                            .glassEffect()
                            .padding(.trailing, 14)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    FeedCardView(
        review: Review(
            id: "previewReview",
            reviewTitle: "Super groove",
            markReview: 5,
            userReview: "La ligne de basse est incroyable.",
            usernameFromUser: ["julien"],
            album: nil,
            track: nil
        ),
        album: nil,
        track: nil
    )
}
