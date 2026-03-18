//
//  OtherUserProfilView.swift
//  GroupeArt
//
//  Created by FUVE on 18/03/2026.
//

import SwiftUI

struct OtherUserProfileView: View {
    let user: User
    
    @State private var otherUserFilter: Int = 0

    struct RoundedCorner: Shape {
        var radius: CGFloat = 30
        var corners: UIRectCorner = [.topLeft, .topRight]

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            return Path(path.cgPath)
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

    // À brancher sur une vraie logique de suivi plus tard
    @State private var isFollowing = false

    var body: some View {
        ZStack {
            backgroundGradient.ignoresSafeArea()

            VStack(spacing: 0) {

                // MARK: - User Info
                HStack(alignment: .top, spacing: 16) {
                    if let urlString = user.userPic?.first?.url,
                       let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 112, height: 112)
                                .cornerRadius(14)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(.orange, lineWidth: 3)
                                )
                        } placeholder: {
                            Color.gray.opacity(0.3)
                                .frame(width: 112, height: 112)
                                .cornerRadius(14)
                                .overlay(ProgressView())
                        }
                    } else {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 112, height: 112)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray)
                            )
                    }

                    VStack(alignment: .leading) {
                        HStack {
                            Text(user.username)
                                .font(.system(size: 20, weight: .semibold))
                            if user.certification == true {
                                Image(systemName: "checkmark.seal")
                                    .foregroundColor(.orange)
                            }
                        }
                        Label(user.userLocation ?? "", systemImage: "location.fill")
                            .font(.footnote)
                            .foregroundColor(.orangeArt)

                        Spacer()

                        HStack(spacing: 30) {
                            VStack {
                                Text("\(user.followers ?? 0)")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("followers")
                            }
                            VStack {
                                Text("\(user.following ?? 0)")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("following")
                            }
                            VStack {
                                Text("\(user.countReviews ?? 0)")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("Avis")
                            }
                        }
                    }
                    .frame(maxHeight: .infinity)
                }
                .frame(height: 112)
                .padding(.horizontal, 16)
                .padding(.top, 16)

                // MARK: - Bio
                if let bio = user.bio, !bio.isEmpty {
                    VStack(alignment: .leading) {
                        Text(bio)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding(.leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 32)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 28)
                                .fill(.ultraThinMaterial)
                            RoundedRectangle(cornerRadius: 28)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        }
                    )
                    .cornerRadius(28)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                }

                // MARK: - Action Buttons
                HStack {
                    // Suivre / Ne plus suivre
                    Button {
                        isFollowing.toggle()
                    } label: {
                        Text(isFollowing ? "Ne plus suivre" : "Suivre")
                            .font(.body)
                            .foregroundColor(isFollowing ? .white : .black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 32)
                            .background(isFollowing ? Color.gray.opacity(0.6) : Color.orange.opacity(0.8))
                            .clipShape(Capsule())
                            .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 4)
                    }

                    Button {} label: {
                        Text("Partager le profil")
                            .font(.body)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 32)
                            .background(Color.black.opacity(0.8))
                            .clipShape(Capsule())
                            .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 4)
                    }
                }
                .padding(16)

                // MARK: - Reviews Panel
                VStack(alignment: .leading) {
                Picker("Filtrer par type", selection: $otherUserFilter) {
                    HStack {
                        Image(systemName: "star.fill")
                        Text("Avis")
                    }.tag(0)

                    HStack {
                        Image(systemName: "menucard")
                        Text("Albums Favoris")
                    }.tag(1)
                    HStack {
                        Image(systemName: "music.microphone")
                        Text("Artistes Favoris")
                    }.tag(2)
                    HStack {
                        Image(systemName: "music.note.house")
                        Text("Concerts Vus")
                    }.tag(3)
                }
                .accentColor(.orangeArt)
                .padding()
                .font(.headline)
                .fontWeight(.semibold)
                .offset(y: 4)
                    ScrollView {

                        switch otherUserFilter {
                        case 0:
                            UserReviewsList(username:user.username)
                        case 1:
                            AlbumFavoriteDetailView()
                        case 2:
                            ArtistFavoriteDetailView()
                        case 3:
                            ConcertFavoriteDetailView()
                        default:
                            EmptyView()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                .background(
                    ZStack {
                        RoundedCorner(radius: 30, corners: [.topLeft, .topRight])
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: -6)
                        backgroundGradient.ignoresSafeArea()
                            .clipShape(
                                RoundedCorner(radius: 30, corners: [.topLeft, .topRight])
                            )
                    }
                )
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    NavigationStack {
        OtherUserProfileView(user: User(
            username: "thefuve",
            userPic: [AirtableAttachment(
                url: "https://v5.airtableusercontent.com/v3/u/51/51/1773849600000/pOGc3xYlIfoU89UAjzMl5Q/Gs7a9i_2sdh18Txxt6StSa8DMzJWlZWSELltIHX9KqJat-wAiVW3EkKrfeL2BxnAZW5HeKwOGo_1rIraHXL0hWpBSRRKObwA3azuz69YM_5cWOKze0kKaG_249JffByOzXUuL8rUM8RAbSKH8ZVAFg/06VOKuLucfR7EDa0N6nn4I0JD1Hb93a4VaCJvXOgmec",
                filename: nil,
                thumbnails: nil
            )],
            certification: true,
            userLocation: "Toronto, Canada",
            followers: 4000,
            following: 344,
            countReviews: 33,
            bio: nil
        ))
    }
}
