import SwiftUI

struct ContentView: View {

    @State private var albumVM = AlbumViewModel()
    var specificAlbum: Album
    @State var trackList: [Track] = []

    private var displayedAlbum: Album? {
        specificAlbum ?? albumVM.randomAlbum
    }

    private var appBackgroundGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.96, green: 0.92, blue: 0.85),
                Color(red: 0.90, green: 0.86, blue: 0.80),
                Color(red: 0.82, green: 0.82, blue: 0.82),
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    var body: some View {
        ZStack {
            appBackgroundGradient
                .ignoresSafeArea()

            if let album = displayedAlbum {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 18) {

                        // Cover album en grand en haut
                        if let urlString = album.coverURL,
                            let url = URL(string: urlString)
                        {
                            AsyncImage(url: url) { image in
                                ZStack {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .scaleEffect(1.05)
                                    Color.black.opacity(0.35)
                                }
                            } placeholder: {
                                appBackgroundGradient
                                    .overlay(ProgressView())
                            }
                            .frame(
                                maxWidth: .infinity,
                                minHeight: 340,
                                maxHeight: 340
                            )
                            .clipped()
                        } else {
                            appBackgroundGradient
                                .frame(
                                    maxWidth: .infinity,
                                    minHeight: 340,
                                    maxHeight: 340
                                )
                                .overlay(
                                    Image(systemName: "music.note")
                                        .font(.system(size: 60))
                                        .foregroundColor(.black.opacity(0.35))
                                )
                        }

                        HeaderCardView(album: album)

                        HStack(spacing: 12) {
                            Button(action: {}) {
                                Text("Ajouter un avis")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.orange)
                                    .clipShape(Capsule())
                                    .shadow(
                                        color: .black.opacity(0.15),
                                        radius: 5,
                                        x: 0,
                                        y: 4
                                    )
                            }

                            Button(action: {}) {
                                Text("Partager")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.black.opacity(0.8))
                                    .clipShape(Capsule())
                                    .shadow(
                                        color: .black.opacity(0.15),
                                        radius: 5,
                                        x: 0,
                                        y: 4
                                    )
                            }

                            Button(action: {}) {
                                Image(systemName: "list.bullet")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.black)
                                    .frame(width: 60, height: 50)
                                    .background(Color.orange)
                                    .clipShape(Capsule())
                                    .shadow(
                                        color: .black.opacity(0.15),
                                        radius: 5,
                                        x: 0,
                                        y: 4
                                    )
                            }
                        }
                        .padding(.horizontal, 24)

                        TracklistCardView(album: album, albumTracks: trackList)
                        {}

                        ReviewsCardView(album: album)
                    }
                    .padding(.bottom, 24)
                }
                .ignoresSafeArea(edges: .top)
            } else {
                ProgressView("Chargement d'un album…")
            }
        }
        .task {

            // Toujours charger la table Track, meme si on arrive avec un album specifique
            if let tracks = self.specificAlbum.tracks {
                for id in tracks {
                    do {
                        let t = try await albumVM.fetchTrackByID(id)
                        self.trackList.append(t)
                        print(t.trackTitle)
                    } catch {
                        print("Erreur: \(error)")
                    }
                }
            }

        }
    }
}

struct HeaderCardView: View {
    let album: Album

    private var appBackgroundGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.96, green: 0.92, blue: 0.85),
                Color(red: 0.90, green: 0.86, blue: 0.80),
                Color(red: 0.82, green: 0.82, blue: 0.82),
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.7))
                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 6)

            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(album.albumTitle)
                        .font(.system(size: 22, weight: .bold))
                        .lineLimit(3)
                        .minimumScaleFactor(0.75)
                        .layoutPriority(1)

                    Text(album.artistName)
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .lineLimit(2)
                        .minimumScaleFactor(0.8)

                    HStack(spacing: 6) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                        Text(String(format: "%.1f", album.globalReview))
                            .font(.system(size: 16, weight: .bold))
                    }
                    .padding(.top, 2)

                    if let year = album.yearRelease {
                        Text(year)
                            .font(.system(size: 14))
                            .foregroundColor(.black.opacity(0.65))
                    }
                }

                Spacer(minLength: 0)

                // Photo artiste en carré à droite
                if let urlString = album.artistPicURL,
                    let url = URL(string: urlString)
                {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        appBackgroundGradient
                            .overlay(ProgressView())
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.35))
                        .frame(width: 100, height: 100)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.black.opacity(0.35))
                        )
                }
            }
            .padding(16)
        }
        .frame(minHeight: 140)
        .padding(.horizontal, 24)
        .offset(y: -40)
        .padding(.bottom, -40)
    }
}

struct ActionButtonView: View {
    let title: String
    let backgroundColor: Color
    let textColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(backgroundColor)
                .clipShape(Capsule())
                .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 4)
        }
    }
}

struct TracklistCardView: View {
    var album: Album
    let albumTracks: [Track]
    let actionVoirAlbum: () -> Void

    @State private var isExpanded = false

    var body: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.72))
                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 6)

            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Spacer()
                    Text("TRACKLIST")
                        .font(.system(size: 24, weight: .black))
                }

                if albumTracks.isEmpty {
                    Text("Aucune track disponible pour cet album")
                        .foregroundColor(.secondary)
                } else {
                    let count = albumTracks.count
                    let displayedCount = isExpanded ? count : min(4, count)

                    ForEach(0..<displayedCount, id: \.self) { index in
                        let track = albumTracks[index]

                        HStack(alignment: .top) {
                            Text("\(index + 1)")
                                .font(.system(size: 15))
                                .frame(width: 20)

                            VStack(alignment: .leading, spacing: 4) {
                                // Simplified logic since we are iterating valid indices
                                Text(track.trackTitle)
                                    .font(.system(size: 19, weight: .bold))

                                Text(album.artistName)
                                    .font(.system(size: 15))
                                    .foregroundColor(.orange)
                            }

                            Spacer()

                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                                if let mark = track.trackMark {
                                    Text(" \(mark) / 5")
                                        .font(.system(size: 17))
                                }
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.orange)
                            }
                        }

                        if index < displayedCount - 1 {
                            Divider()
                        }
                    }

                    if count > 4 {
                        if !isExpanded {
                            Button(action: {
                                withAnimation {
                                    isExpanded = true
                                }
                            }) {
                                Text("Voir tout l'album")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 40)
                                    .background(Color.orange)
                                    .clipShape(Capsule())
                                    .shadow(
                                        color: .black.opacity(0.15),
                                        radius: 4,
                                        x: 0,
                                        y: 2
                                    )
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 8)
                        } else {
                            Button(action: {
                                withAnimation {
                                    isExpanded = false
                                }
                            }) {
                                Text("Voir moins")
                                    .font(.system(size: 14))
                                    .foregroundColor(.secondary)
                                    .padding(.top, 8)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
            .padding(24)
        }
        .padding(.horizontal, 24)
    }
}

struct ReviewsCardView: View {
    let album: Album

    var body: some View {
        let titles = album.reviewTitleFromTopReview ?? []
        let reviews = album.userReviewFromTopReview ?? []
        let usernames = album.usernameFromTopReview ?? []
        let marks = album.markFromTopReview ?? []

        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.72))
                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 6)

            VStack(alignment: .leading, spacing: 18) {
                HStack {
                    Spacer()
                    Text("REVIEWS")
                        .font(.system(size: 24, weight: .black))
                }

                if titles.isEmpty {
                    Text("Aucune review pour cet album")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(0..<titles.count, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text(titles[index])
                                    .font(.system(size: 18, weight: .bold))
                                Spacer()
                                if index < usernames.count {
                                    Text(usernames[index])
                                        .font(.system(size: 14))
                                }
                            }

                            if index < marks.count {
                                HStack(spacing: 2) {
                                    ForEach(0..<Int(marks[index]), id: \.self) {
                                        _ in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.orange)
                                            .font(.system(size: 14))
                                    }
                                    ForEach(
                                        0..<(5 - Int(marks[index])),
                                        id: \.self
                                    ) { _ in
                                        Image(systemName: "star")
                                            .foregroundColor(.orange)
                                            .font(.system(size: 14))
                                    }
                                }
                            }

                            if index < reviews.count {
                                Text(reviews[index])
                                    .font(.system(size: 15))
                                    .foregroundColor(.black.opacity(0.8))
                                    .lineLimit(3)
                            }

                            if index < titles.count - 1 {
                                Divider()
                            }
                        }
                    }
                }
            }
            .padding(24)
        }
        .padding(.horizontal, 24)
    }
}
