import SwiftUI

struct SearchView: View {
    enum SearchFilter: String, CaseIterable {
        case albums = "Albums"
        case tracks = "Tracks"
        case artists = "Artistes"
        case concerts = "Concerts"
    }

    struct SearchTrack: Identifiable {
        let id = UUID()
        let track: Track
        let album: Album
    }

    struct ConcertDetailPlaceholderView: View {
        let concert: Concert

        var body: some View {
            ZStack {
                LinearGradient(
                    stops: [
                        .init(color: .grisArt, location: 0.07),
                        .init(color: .beigeArt, location: 0.66),
                        .init(color: .orangeArt, location: 1.0)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    if let urlString = concert.coverURL, let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.white.opacity(0.25))
                                .overlay(ProgressView())
                        }
                        .frame(width: 220, height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                    }

                    Text(concert.concertTitle)
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.center)

                    Text(concert.artistName)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.secondary)

                    if let date = concert.concertDate {
                        Text(date)
                            .font(.system(size: 16))
                    }

                    if let hall = concert.concertHall, let city = concert.concertLocation {
                        Text("\(hall) • \(city)")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                    }

                    Text("Remplace cette vue par ta vraie page concert quand tu me l’envoies.")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                .padding(24)
            }
            .navigationTitle("Concert")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    @State private var searchText: String = ""
    @State private var selectedFilter: SearchFilter = .albums
    @FocusState private var isSearchFocused: Bool

    let albums: [Album]
    let artists: [Artist]
    let concerts: [Concert]
    let tracks: [SearchTrack]

    init(
        albums: [Album] = [],
        artists: [Artist] = [],
        concerts: [Concert] = [],
        tracks: [SearchTrack] = []
    ) {
        self.albums = albums
        self.artists = artists
        self.concerts = concerts
        self.tracks = tracks
    }

    private var normalizedSearchText: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var filteredAlbums: [Album] {
        if normalizedSearchText.isEmpty {
            return albums
        }

        let query = normalizedSearchText.lowercased()
        return albums.filter {
            $0.albumTitle.lowercased().contains(query) ||
            $0.artistName.lowercased().contains(query)
        }
    }

    private var albumSuggestions: [Album] {
        guard !normalizedSearchText.isEmpty else { return [] }
        return Array(filteredAlbums.prefix(6))
    }

    private var filteredArtists: [Artist] {
        if normalizedSearchText.isEmpty {
            return artists
        }

        let query = normalizedSearchText.lowercased()
        return artists.filter {
            $0.artistName.lowercased().contains(query) ||
            ($0.artistDescription?.lowercased().contains(query) ?? false)
        }
    }

    private var filteredConcerts: [Concert] {
        if normalizedSearchText.isEmpty {
            return concerts
        }

        let query = normalizedSearchText.lowercased()
        return concerts.filter {
            $0.concertTitle.lowercased().contains(query) ||
            $0.artistName.lowercased().contains(query) ||
            ($0.concertHall?.lowercased().contains(query) ?? false) ||
            ($0.concertLocation?.lowercased().contains(query) ?? false)
        }
    }

    private var filteredTracks: [SearchTrack] {
        if normalizedSearchText.isEmpty {
            return tracks
        }

        let query = normalizedSearchText.lowercased()
        return tracks.filter {
            $0.track.trackTitle.lowercased().contains(query) ||
            $0.album.albumTitle.lowercased().contains(query) ||
            $0.album.artistName.lowercased().contains(query)
        }
    }

    private var backgroundGradient: LinearGradient {
        LinearGradient(
            stops: [
                .init(color: .grisArt, location: 0.07),
                .init(color: .beigeArt, location: 0.66),
                .init(color: .orangeArt, location: 1.0)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundGradient
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Rechercher")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.black)

                        Menu {
                            ForEach(SearchFilter.allCases, id: \.self) { filter in
                                Button {
                                    selectedFilter = filter
                                } label: {
                                    HStack {
                                        Text(filter.rawValue)
                                        if selectedFilter == filter {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        } label: {
                            HStack(spacing: 4) {
                                Text(selectedFilter.rawValue)
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.orangeArt)

                                Image(systemName: "chevron.up.chevron.down")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.orangeArt)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                    .padding(.bottom, 16)

                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 14) {

                            // Suggestions de recherche
                            if selectedFilter == .albums && !albumSuggestions.isEmpty {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Suggestions")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 6)

                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color.white.opacity(0.55))
                                        .overlay {
                                            VStack(spacing: 0) {
                                                ForEach(Array(albumSuggestions.enumerated()), id: \.element.id) { index, album in
                                                    NavigationLink {
                                                        ContentView(specificAlbum: album)
                                                    } label: {
                                                        HStack(spacing: 12) {
                                                            Image(systemName: "magnifyingglass")
                                                                .foregroundColor(.gray)

                                                            VStack(alignment: .leading, spacing: 2) {
                                                                Text(album.albumTitle)
                                                                    .font(.system(size: 16, weight: .semibold))
                                                                    .foregroundColor(.black)

                                                                Text(album.artistName)
                                                                    .font(.system(size: 14))
                                                                    .foregroundColor(.gray)
                                                            }

                                                            Spacer()
                                                        }
                                                        .padding(.horizontal, 16)
                                                        .padding(.vertical, 12)
                                                    }
                                                    .buttonStyle(.plain)

                                                    if index < albumSuggestions.count - 1 {
                                                        Divider()
                                                            .padding(.horizontal, 16)
                                                    }
                                                }
                                            }
                                        }
                                }
                                .padding(.horizontal, 18)
                            }

                            RoundedRectangle(cornerRadius: 28)
                                .fill(Color.white.opacity(0.55))
                                .overlay {
                                    VStack(spacing: 0) {
                                        if selectedFilter == .albums {
                                            if filteredAlbums.isEmpty {
                                                Text(normalizedSearchText.isEmpty ? "Aucun album disponible" : "Aucun album trouvé")
                                                    .font(.system(size: 16, weight: .medium))
                                                    .foregroundColor(.secondary)
                                                    .padding(.vertical, 32)
                                            } else {
                                                ForEach(Array(filteredAlbums.enumerated()), id: \.element.id) { index, album in
                                                    NavigationLink {
                                                        ContentView(specificAlbum: album)
                                                    } label: {
                                                        HStack(spacing: 14) {
                                                            VStack(alignment: .leading, spacing: 4) {
                                                                Text(album.albumTitle)
                                                                    .font(.system(size: 18, weight: .bold))
                                                                    .foregroundColor(.black)
                                                                    .multilineTextAlignment(.leading)

                                                                Text(album.artistName)
                                                                    .font(.system(size: 15, weight: .medium))
                                                                    .foregroundColor(.gray)

                                                                HStack(spacing: 4) {
                                                                    Image(systemName: "star.fill")
                                                                        .foregroundColor(.orangeArt)

                                                                    Text(String(format: "%.1f", album.globalReview))
                                                                        .font(.system(size: 15, weight: .bold))
                                                                        .foregroundColor(.black)
                                                                }
                                                            }

                                                            Spacer()

                                                            if let urlString = album.coverURL, let url = URL(string: urlString) {
                                                                AsyncImage(url: url) { image in
                                                                    image
                                                                        .resizable()
                                                                        .scaledToFill()
                                                                } placeholder: {
                                                                    RoundedRectangle(cornerRadius: 18)
                                                                        .fill(Color.gray.opacity(0.2))
                                                                        .overlay(ProgressView())
                                                                }
                                                                .frame(width: 64, height: 64)
                                                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                                            } else {
                                                                RoundedRectangle(cornerRadius: 18)
                                                                    .fill(Color.gray.opacity(0.2))
                                                                    .frame(width: 64, height: 64)
                                                                    .overlay(
                                                                        Image(systemName: "music.note")
                                                                            .foregroundColor(.gray)
                                                                    )
                                                            }

                                                            Image(systemName: "chevron.right")
                                                                .foregroundColor(.gray)
                                                                .font(.system(size: 14, weight: .semibold))
                                                        }
                                                        .padding(.horizontal, 18)
                                                        .padding(.vertical, 14)
                                                        .contentShape(Rectangle())
                                                    }
                                                    .buttonStyle(.plain)

                                                    if index < filteredAlbums.count - 1 {
                                                        Divider()
                                                            .padding(.leading, 18)
                                                            .padding(.trailing, 18)
                                                    }
                                                }
                                            }
                                        }

                                        if selectedFilter == .artists {
                                            if filteredArtists.isEmpty {
                                                Text("Aucun artiste trouvé")
                                                    .font(.system(size: 16, weight: .medium))
                                                    .foregroundColor(.secondary)
                                                    .padding(.vertical, 32)
                                            } else {
                                                ForEach(Array(filteredArtists.enumerated()), id: \.element.id) { index, artist in
                                                    NavigationLink {
                                                        ArtistView(artist: artist)
                                                    } label: {
                                                        HStack(spacing: 14) {
                                                            VStack(alignment: .leading, spacing: 4) {
                                                                Text(artist.artistName)
                                                                    .font(.system(size: 18, weight: .bold))
                                                                    .foregroundColor(.black)
                                                                    .multilineTextAlignment(.leading)

                                                                Text(artist.artistDescription ?? "Aucune description")
                                                                    .font(.system(size: 14, weight: .medium))
                                                                    .foregroundColor(.gray)
                                                                    .lineLimit(2)
                                                            }

                                                            Spacer()

                                                            if let urlString = artist.pictureURL, let url = URL(string: urlString) {
                                                                AsyncImage(url: url) { image in
                                                                    image
                                                                        .resizable()
                                                                        .scaledToFill()
                                                                } placeholder: {
                                                                    RoundedRectangle(cornerRadius: 18)
                                                                        .fill(Color.gray.opacity(0.2))
                                                                        .overlay(ProgressView())
                                                                }
                                                                .frame(width: 64, height: 64)
                                                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                                            } else {
                                                                RoundedRectangle(cornerRadius: 18)
                                                                    .fill(Color.gray.opacity(0.2))
                                                                    .frame(width: 64, height: 64)
                                                                    .overlay(
                                                                        Image(systemName: "person.fill")
                                                                            .foregroundColor(.gray)
                                                                    )
                                                            }

                                                            Image(systemName: "chevron.right")
                                                                .foregroundColor(.gray)
                                                                .font(.system(size: 14, weight: .semibold))
                                                        }
                                                        .padding(.horizontal, 18)
                                                        .padding(.vertical, 14)
                                                        .contentShape(Rectangle())
                                                    }
                                                    .buttonStyle(.plain)

                                                    if index < filteredArtists.count - 1 {
                                                        Divider()
                                                            .padding(.leading, 18)
                                                            .padding(.trailing, 18)
                                                    }
                                                }
                                            }
                                        }

                                        if selectedFilter == .concerts {
                                            if filteredConcerts.isEmpty {
                                                Text("Aucun concert trouvé")
                                                    .font(.system(size: 16, weight: .medium))
                                                    .foregroundColor(.secondary)
                                                    .padding(.vertical, 32)
                                            } else {
                                                ForEach(Array(filteredConcerts.enumerated()), id: \.element.id) { index, concert in
                                                    NavigationLink {
                                                        ConcertDetailPlaceholderView(concert: concert)
                                                    } label: {
                                                        HStack(spacing: 14) {
                                                            VStack(alignment: .leading, spacing: 4) {
                                                                Text(concert.concertTitle)
                                                                    .font(.system(size: 18, weight: .bold))
                                                                    .foregroundColor(.black)

                                                                Text(concert.artistName)
                                                                    .font(.system(size: 15, weight: .medium))
                                                                    .foregroundColor(.gray)

                                                                Text(
                                                                    [
                                                                        concert.concertDate,
                                                                        concert.concertHall,
                                                                        concert.concertLocation
                                                                    ]
                                                                    .compactMap { $0 }
                                                                    .joined(separator: " • ")
                                                                )
                                                                .font(.system(size: 14, weight: .medium))
                                                                .foregroundColor(.gray)
                                                                .lineLimit(2)
                                                            }

                                                            Spacer()

                                                            if let urlString = concert.coverURL, let url = URL(string: urlString) {
                                                                AsyncImage(url: url) { image in
                                                                    image
                                                                        .resizable()
                                                                        .scaledToFill()
                                                                } placeholder: {
                                                                    RoundedRectangle(cornerRadius: 18)
                                                                        .fill(Color.gray.opacity(0.2))
                                                                        .overlay(ProgressView())
                                                                }
                                                                .frame(width: 64, height: 64)
                                                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                                            } else {
                                                                RoundedRectangle(cornerRadius: 18)
                                                                    .fill(Color.gray.opacity(0.2))
                                                                    .frame(width: 64, height: 64)
                                                                    .overlay(
                                                                        Image(systemName: "music.mic")
                                                                            .foregroundColor(.gray)
                                                                    )
                                                            }

                                                            Image(systemName: "chevron.right")
                                                                .foregroundColor(.gray)
                                                                .font(.system(size: 14, weight: .semibold))
                                                        }
                                                        .padding(.horizontal, 18)
                                                        .padding(.vertical, 14)
                                                        .contentShape(Rectangle())
                                                    }
                                                    .buttonStyle(.plain)

                                                    if index < filteredConcerts.count - 1 {
                                                        Divider()
                                                            .padding(.leading, 18)
                                                            .padding(.trailing, 18)
                                                    }
                                                }
                                            }
                                        }

                                        if selectedFilter == .tracks {
                                            if filteredTracks.isEmpty {
                                                Text("Aucune track trouvée")
                                                    .font(.system(size: 16, weight: .medium))
                                                    .foregroundColor(.secondary)
                                                    .padding(.vertical, 32)
                                            } else {
                                                ForEach(Array(filteredTracks.enumerated()), id: \.element.id) { index, item in
                                                    NavigationLink {
                                                        ContentView(specificAlbum: item.album)
                                                    } label: {
                                                        HStack(spacing: 14) {
                                                            VStack(alignment: .leading, spacing: 4) {
                                                                Text(item.track.trackTitle)
                                                                    .font(.system(size: 18, weight: .bold))
                                                                    .foregroundColor(.black)

                                                                Text(item.album.artistName)
                                                                    .font(.system(size: 15, weight: .medium))
                                                                    .foregroundColor(.gray)

                                                                Text(item.album.albumTitle)
                                                                    .font(.system(size: 14, weight: .medium))
                                                                    .foregroundColor(.orangeArt)
                                                                    .lineLimit(1)

                                                                if let mark = item.track.trackMark {
                                                                    HStack(spacing: 4) {
                                                                        Image(systemName: "star.fill")
                                                                            .foregroundColor(.orangeArt)
                                                                        Text("\(mark)")
                                                                            .font(.system(size: 15, weight: .bold))
                                                                            .foregroundColor(.black)
                                                                    }
                                                                }
                                                            }

                                                            Spacer()

                                                            if let urlString = item.album.coverURL, let url = URL(string: urlString) {
                                                                AsyncImage(url: url) { image in
                                                                    image
                                                                        .resizable()
                                                                        .scaledToFill()
                                                                } placeholder: {
                                                                    RoundedRectangle(cornerRadius: 18)
                                                                        .fill(Color.gray.opacity(0.2))
                                                                        .overlay(ProgressView())
                                                                }
                                                                .frame(width: 64, height: 64)
                                                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                                            } else {
                                                                RoundedRectangle(cornerRadius: 18)
                                                                    .fill(Color.gray.opacity(0.2))
                                                                    .frame(width: 64, height: 64)
                                                                    .overlay(
                                                                        Image(systemName: "music.note")
                                                                            .foregroundColor(.gray)
                                                                    )
                                                            }

                                                            Image(systemName: "chevron.right")
                                                                .foregroundColor(.gray)
                                                                .font(.system(size: 14, weight: .semibold))
                                                        }
                                                        .padding(.horizontal, 18)
                                                        .padding(.vertical, 14)
                                                        .contentShape(Rectangle())
                                                    }
                                                    .buttonStyle(.plain)

                                                    if index < filteredTracks.count - 1 {
                                                        Divider()
                                                            .padding(.leading, 18)
                                                            .padding(.trailing, 18)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(6)
                                .padding(.bottom, 8)
                                .padding(.horizontal, 18)

                            Spacer(minLength: 100)
                        }
                    }

                    HStack(spacing: 12) {
                        Button {
                        } label: {
                            Image(systemName: "house")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(.black)
                                .frame(width: 48, height: 48)
                                .background(Color.white.opacity(0.75))
                                .clipShape(Circle())
                        }

                        HStack(spacing: 10) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)

                            TextField("Rechercher un album", text: $searchText)
                                .textFieldStyle(.plain)
                                .foregroundColor(.black)
                                .focused($isSearchFocused)
                                .submitLabel(.search)

                            if !searchText.isEmpty {
                                Button {
                                    searchText = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }

                            Image(systemName: "mic.fill")
                                .foregroundColor(.black.opacity(0.75))
                        }
                        .padding(.horizontal, 16)
                        .frame(height: 48)
                        .background(Color.white.opacity(0.75))
                        .clipShape(Capsule())
                    }
                    .padding(.horizontal, 22)
                    .padding(.bottom, 18)
                    .padding(.top, 10)
                    .background(.ultraThinMaterial.opacity(0.35))
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    SearchView()
}
