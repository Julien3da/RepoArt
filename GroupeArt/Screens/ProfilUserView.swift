//
//  ProfilUserView.swift
//  GroupeArt
//
//  Created by apprenant84 on 12/03/2026.
//

import SwiftUI

struct ProfilUserView: View {
    private let currentUserId = "recwAC44d2sQ2kwql"
    @State private var userVM = UserViewModel()
    @State private var currentUser: User? = nil

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

    struct SmallActionButtonView: View {
        let title: String
        let backgroundColor: Color
        let textColor: Color
        let action: () -> Void

        var body: some View {
            Button(action: action) {
                Text(title)
                    .font(.body)
                    .foregroundColor(textColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
                    .background(backgroundColor)
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 4)
            }
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
        NavigationStack {
            ZStack {
                backgroundGradient.ignoresSafeArea()

                VStack(spacing: 0) {

                    // MARK: - Header
                    HStack {
                        Spacer()
                        NavigationLink(destination: ProfileSettingsV()) {
                            Image(systemName: "gearshape.fill")
                                .foregroundStyle(.orangeArt)
                                .padding(.trailing, 24)
                                .padding(.top)
                                .font(.system(size: 24))
                        }
                    }
                    .padding(.top, 32)

                    // MARK: - User Info
                    HStack(alignment: .top, spacing: 16) {
                        if let urlString = currentUser?.userPic?.first?.url,
                           let url = URL(string: urlString) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 112, height: 112)
                                    .cornerRadius(14)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14)
                                            .stroke(.orangeArt, lineWidth: 3)
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
                                Text(currentUser?.username ?? "Chargement...")
                                    .font(.system(size: 20, weight: .semibold))
                                Image(systemName: "checkmark.seal")
                                    .foregroundColor(.orangeArt)
                            }
                            Label(currentUser?.userLocation ?? "", systemImage: "location.fill")
                                .font(.footnote)
                                .foregroundColor(.orangeArt)

                            Spacer()

                            HStack(spacing: 30) {
                                VStack {
                                    Text("\(currentUser?.followers ?? 0)")
                                        .font(.system(size: 16, weight: .semibold))
                                    Text("followers")
                                }
                                VStack {
                                    Text("\(currentUser?.following ?? 0)")
                                        .font(.system(size: 16, weight: .semibold))
                                    Text("following")
                                }
                                VStack {
                                    Text("\(currentUser?.countReviews ?? 0)")
                                        .font(.system(size: 16, weight: .semibold))
                                    Text("Avis")
                                }
                            }
                        }
                        .frame(maxHeight: .infinity)
                    }
                    .frame(height: 112)
                    .padding(.horizontal, 16)

                    // MARK: - Bio
                    VStack(alignment: .leading) {
                        Text(currentUser?.bio ?? "")
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
                    .background(Color.grisArt.opacity(0.1))
                    .cornerRadius(28)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)

                    // MARK: - Action Buttons
                    HStack {
                        if let user = currentUser {
                            NavigationLink(destination: EditProfileV(user: user)) {
                                Text("Modifier le profil")
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 32)
                                    .background(Color.orangeArt.opacity(0.8))
                                    .clipShape(Capsule())
                                    .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 4)
                            }
                        } else {
                            SmallActionButtonView(
                                title: "Modifier le profil",
                                backgroundColor: Color.orangeArt.opacity(0.8),
                                textColor: .black) {}
                        }
                        SmallActionButtonView(
                            title: "Partager le profil",
                            backgroundColor: Color.black.opacity(0.8),
                            textColor: .white) {}
                    }
                    .padding(16)

                    // MARK: - Reviews Panel
                    VStack {
                        Text("Mes avis")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                            .font(.headline)
                            .fontWeight(.semibold)
                            
                            .padding(.top, 8)
                            .padding(.bottom, 4)

                        ScrollView {
                            if let username = currentUser?.username {
                                UserReviewsList(username: username)
                                    .padding(.bottom, 32)
                            } else {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                                    .padding(.top, 32)
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
                .ignoresSafeArea()
            }
        }
        .task {
            do {
                let users = try await userVM.fetchUsers()
                currentUser = users.first(where: { $0.recordId == currentUserId })
                print("currentUser chargé: \(currentUser?.username ?? "nil")")
            } catch {
                print("Erreur chargement user: \(error)")
            }
        }
    }
}

#Preview {
    ProfilUserView()
}
