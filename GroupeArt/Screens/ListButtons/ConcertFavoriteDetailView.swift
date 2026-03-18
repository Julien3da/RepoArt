//
//  ConcertFavoriteDetailView.swift
//  GroupeArt
//
//  Created by Julien Estrada on 11/03/2026.
//

import SwiftUI

struct ConcertFavoriteDetailView: View {

    @State private var concertVM = ConcertViewModel()
    @State private var searchText = ""

    private var filteredConcerts: [Concert] {
        guard !searchText.isEmpty else { return concertVM.concerts }
        return concertVM.concerts.filter {
            $0.concertTitle.localizedCaseInsensitiveContains(searchText) ||
            $0.artistName.localizedCaseInsensitiveContains(searchText) ||
            ($0.concertLocation ?? "").localizedCaseInsensitiveContains(searchText) ||
            ($0.concertHall ?? "").localizedCaseInsensitiveContains(searchText)
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
                        RoundedRectangle(cornerRadius: 32)
                            .fill(Color.white.opacity(0.85))
                            .frame(width: 200, height: 200)
                            .shadow(color: .black.opacity(0.1), radius: 16, x: 0, y: 6)

                        Image(systemName: "music.note.house")
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

                    Text("Concerts vus")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(.bottom, 24)

                    if concertVM.concerts.isEmpty {
                        ProgressView("Chargement…")
                            .padding(.top, 40)
                    } else {
                        VStack(spacing: 0) {
                            ForEach(Array(filteredConcerts.enumerated()), id: \.element.id) { index, concert in
                                NavigationLink(destination: ConcertView(concert: concert)) {
                                    VStack(spacing: 0) {
                                        HStack(spacing: 14) {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(concert.concertTitle)
                                                    .font(.system(size: 17, weight: .semibold))
                                                    .foregroundColor(.primary)

                                                Text(concert.artistName)
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.secondary)

                                                if let date = concert.concertDate {
                                                    HStack(spacing: 4) {
                                                        Image(systemName: "calendar")
                                                            .font(.system(size: 12))
                                                            .foregroundColor(.orangeArt)
                                                        Text(date)
                                                            .font(.system(size: 13))
                                                            .foregroundColor(.secondary)
                                                    }
                                                }

                                                if let location = concert.concertLocation {
                                                    HStack(spacing: 4) {
                                                        Image(systemName: "mappin.and.ellipse")
                                                            .font(.system(size: 12))
                                                            .foregroundColor(.orangeArt)
                                                        Text(location)
                                                            .font(.system(size: 13))
                                                            .foregroundColor(.secondary)
                                                    }
                                                }

                                                if let hall = concert.concertHall {
                                                    HStack(spacing: 4) {
                                                        Image(systemName: "building.2")
                                                            .font(.system(size: 12))
                                                            .foregroundColor(.orangeArt)
                                                        Text(hall)
                                                            .font(.system(size: 13))
                                                            .foregroundColor(.secondary)
                                                    }
                                                }
                                            }

                                            Spacer()

                                            // Affiche concert depuis l'API
                                            if let urlString = concert.coverURL, let url = URL(string: urlString) {
                                                AsyncImage(url: url) { image in
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                } placeholder: {
                                                    Color.gray.opacity(0.2)
                                                        .overlay(
                                                            Image(systemName: "ticket")
                                                                .font(.system(size: 22))
                                                                .foregroundColor(.gray)
                                                        )
                                                }
                                                .frame(width: 70, height: 100)
                                                .cornerRadius(12)
                                            } else {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(Color.gray.opacity(0.2))
                                                    .frame(width: 60, height: 60)
                                                    .overlay(
                                                        Image(systemName: "ticket")
                                                            .font(.system(size: 22))
                                                            .foregroundColor(.gray)
                                                    )
                                            }

                                            Image(systemName: "chevron.right")
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundColor(.secondary)
                                        }
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 14)

                                        if index < filteredConcerts.count - 1 {
                                            Divider()
                                                .padding(.horizontal, 20)
                                        }
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.6))
                        )
                        .padding(.horizontal, 16)
                        .padding(.bottom, 30)
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Rechercher un concert, artiste ou lieu")
        .task {
            do {
                _ = try await concertVM.fetchConcerts()
            } catch {
                print("Erreur chargement concerts: \(error)")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ConcertFavoriteDetailView()
    }
}
