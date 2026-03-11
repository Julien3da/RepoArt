import SwiftUI

struct ContentView: View {
    
    @State private var albumVM = AlbumViewModel()
    var specificAlbum: Album? = nil
    
    private var displayedAlbum: Album? {
        specificAlbum ?? albumVM.randomAlbum
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.8, green: 0.8, blue: 0.8)
                .ignoresSafeArea()

            if let album = displayedAlbum {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 18) {
                        // Cover album en grand en haut
                        if let urlString = album.coverURL, let url = URL(string: urlString) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                                    .overlay(ProgressView())
                            }
                            .frame(height: 320)
                            .clipShape(RoundedRectangle(cornerRadius: 80))
                        } else {
                            RoundedRectangle(cornerRadius: 80)
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 320)
                                .overlay(
                                    Image(systemName: "music.note")
                                        .font(.system(size: 60))
                                        .foregroundColor(.gray)
                                )
                        }

                        HeaderCardView(album: album)

                        HStack(spacing: 12) {
                            ActionButtonView(
                                title: String(format: "Note : %.1f / 5", album.globalReview),
                                backgroundColor: Color.orange,
                                textColor: .black) {}

                            ActionButtonView(
                                title: "Partager",
                                backgroundColor: Color.black.opacity(0.8),
                                textColor: .white) {}
                        }
                        .padding(.horizontal, 24)

                        TracklistCardView(album: album) {}

                        ReviewsCardView(album: album)
                    }
                    .padding(.bottom, 24)
                }
            } else {
                ProgressView("Chargement d'un album…")
            }
        }
        .task {
            if specificAlbum == nil {
                do {
                    try await albumVM.fetchRandomAlbum()
                } catch {
                    print("Erreur: \(error)")
                }
            }
        }
    }
}

struct HeaderCardView: View {
    let album: Album
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.7))
                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 6)

            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(album.albumTitle)
                        .font(.system(size: 28, weight: .bold))

                    Text(album.artistName)
                        .font(.system(size: 17))
                        .foregroundColor(.gray)

                    HStack(spacing: 6) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                        Text(String(format: "%.1f", album.globalReview))
                            .font(.system(size: 18, weight: .bold))
                    }

                    if let year = album.yearRelease {
                        Text(year)
                            .font(.system(size: 16))
                            .foregroundColor(.black.opacity(0.65))
                    }
                }

                Spacer()

                // Photo artiste en carré à droite
                if let urlString = album.artistPicURL, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                            .overlay(ProgressView())
                    }
                    .frame(width: 145, height: 145)
                    .clipShape(RoundedRectangle(cornerRadius: 28))
                } else {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 145, height: 145)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                        )
                }
            }
            .padding(24)
        }
        .frame(height: 175)
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
    let album: Album
    let actionVoirAlbum: () -> Void

    var body: some View {
        let trackMarks = album.trackMarkFromTracks ?? []
        
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

                if trackMarks.isEmpty {
                    Text("Aucune track disponible")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(0..<min(trackMarks.count, 6), id: \.self) { index in
                        HStack(alignment: .top) {
                            Text("\(index + 1)")
                                .font(.system(size: 20))
                                .frame(width: 20)

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Piste \(index + 1)")
                                    .font(.system(size: 19, weight: .bold))

                                Text(album.artistName)
                                    .font(.system(size: 15))
                                    .foregroundColor(.orange)
                            }

                            Spacer()

                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                                Text("\(trackMarks[index]) / 5")
                                    .font(.system(size: 17))
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.orange)
                            }
                        }

                        if index < min(trackMarks.count, 6) - 1 {
                            Divider()
                        }
                    }
                }

                if trackMarks.count > 6 {
                    HStack {
                        Spacer()
                        Text("+ \(trackMarks.count - 6) pistes")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                        Spacer()
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
                                    ForEach(0..<Int(marks[index]), id: \.self) { _ in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.orange)
                                            .font(.system(size: 14))
                                    }
                                    ForEach(0..<(5 - Int(marks[index])), id: \.self) { _ in
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

#Preview {
    ContentView()
}
