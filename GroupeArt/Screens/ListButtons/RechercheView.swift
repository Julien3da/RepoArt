import SwiftUI

struct SearchView: View {
    enum SearchFilter: String, CaseIterable {
        case albums = "Albums"
        case tracks = "Tracks"
        case artists = "Artistes"
        case concerts = "Concerts"
        case users = "Utilisateurs"
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
                            image.resizable().scaledToFill()
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

                    if let date = concert.concertDate { Text(date).font(.system(size: 16)) }

                    if let hall = concert.concertHall, let city = concert.concertLocation {
                        Text("\(hall) • \(city)")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                    }
                }
                .padding(24)
            }
            .navigationTitle("Concert")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - State
    @State private var searchText: String = ""
    @State private var selectedFilter: SearchFilter = .albums

    @State private var albumVM = AlbumViewModel()
    @State private var artistVM = ArtistViewModel()
    @State private var concertVM = ConcertViewModel()
    @State private var trackVM = TrackViewModel()
    @State private var userVM = UserViewModel()

    // Tracks enrichies (track + album associé)
    @State private var searchTracks: [SearchTrack] = []

    // MARK: - Filtered

    private var normalizedSearchText: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var filteredAlbums: [Album] {
        guard !searchText.isEmpty else { return albumVM.albums }
        return albumVM.albums.filter {
            $0.albumTitle.localizedCaseInsensitiveContains(searchText) ||
            $0.artistName.localizedCaseInsensitiveContains(searchText)
        }
    }

    private var filteredArtists: [Artist] {
        guard !searchText.isEmpty else { return artistVM.artists }
        return artistVM.artists.filter {
            $0.artistName.localizedCaseInsensitiveContains(searchText) ||
            ($0.artistDescription?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }

    private var filteredConcerts: [Concert] {
        guard !searchText.isEmpty else { return concertVM.concerts }
        return concertVM.concerts.filter {
            $0.concertTitle.localizedCaseInsensitiveContains(searchText) ||
            $0.artistName.localizedCaseInsensitiveContains(searchText) ||
            ($0.concertHall?.localizedCaseInsensitiveContains(searchText) ?? false) ||
            ($0.concertLocation?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }

    private var filteredTracks: [SearchTrack] {
        guard !searchText.isEmpty else { return searchTracks }
        return searchTracks.filter {
            $0.track.trackTitle.localizedCaseInsensitiveContains(searchText) ||
            $0.album.albumTitle.localizedCaseInsensitiveContains(searchText) ||
            $0.album.artistName.localizedCaseInsensitiveContains(searchText)
        }
    }

    private var filteredUsers: [User] {
        guard !searchText.isEmpty else { return userVM.users }
        return userVM.users.filter {
            $0.username.localizedCaseInsensitiveContains(searchText) ||
            ($0.userLocation?.localizedCaseInsensitiveContains(searchText) ?? false)
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

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundGradient.ignoresSafeArea()

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
//                            RoundedRectangle(cornerRadius: 28)
//                                .fill(Color.white.opacity(0.55))
//                                .overlay {
                                    VStack(spacing: 0) {

                                        // MARK: Albums
                                        if selectedFilter == .albums {
                                            if filteredAlbums.isEmpty {
                                                emptyText(searchText.isEmpty ? "Aucun album disponible" : "Aucun album trouvé")
                                            } else {
                                                ForEach(Array(filteredAlbums.enumerated()), id: \.element.id) { index, album in
                                                    NavigationLink { ContentView(specificAlbum: album) } label: {
                                                        HStack(spacing: 14) {
                                                            VStack(alignment: .leading, spacing: 4) {
                                                                Text(album.albumTitle)
                                                                    .font(.system(size: 18, weight: .bold))
                                                                    .foregroundColor(.black)
                                                                Text(album.artistName)
                                                                    .font(.system(size: 15, weight: .medium))
                                                                    .foregroundColor(.gray)
                                                                HStack(spacing: 4) {
                                                                    Image(systemName: "star.fill").foregroundColor(.orangeArt)
                                                                    Text(String(format: "%.1f", album.globalReview))
                                                                        .font(.system(size: 15, weight: .bold))
                                                                        .foregroundColor(.black)
                                                                }
                                                            }
                                                            Spacer()
                                                            coverImage(url: album.coverURL, icon: "music.note")
                                                            Image(systemName: "chevron.right").foregroundColor(.gray)
                                                        }
                                                        .rowPadding()
                                                    }
                                                    .buttonStyle(.plain)
                                                    if index < filteredAlbums.count - 1 { rowDivider() }
                                                }
                                            }
                                        }

                                        // MARK: Artists
                                        if selectedFilter == .artists {
                                            if filteredArtists.isEmpty {
                                                emptyText(searchText.isEmpty ? "Aucun artiste disponible" : "Aucun artiste trouvé")
                                            } else {
                                                ForEach(Array(filteredArtists.enumerated()), id: \.element.id) { index, artist in
                                                    NavigationLink { ArtistView(artist: artist) } label: {
                                                        HStack(spacing: 14) {
                                                            VStack(alignment: .leading, spacing: 4) {
                                                                Text(artist.artistName)
                                                                    .font(.system(size: 18, weight: .bold))
                                                                    .foregroundColor(.black)
                                                                Text(artist.artistDescription ?? "Aucune description")
                                                                    .font(.system(size: 14, weight: .medium))
                                                                    .foregroundColor(.gray)
                                                                    .lineLimit(2)
                                                            }
                                                            Spacer()
                                                            coverImage(url: artist.pictureURL, icon: "person.fill")
                                                            Image(systemName: "chevron.right").foregroundColor(.gray)
                                                        }
                                                        .rowPadding()
                                                    }
                                                    .buttonStyle(.plain)
                                                    if index < filteredArtists.count - 1 { rowDivider() }
                                                }
                                            }
                                        }

                                        // MARK: Concerts
                                        if selectedFilter == .concerts {
                                            if filteredConcerts.isEmpty {
                                                emptyText(searchText.isEmpty ? "Aucun concert disponible" : "Aucun concert trouvé")
                                            } else {
                                                ForEach(Array(filteredConcerts.enumerated()), id: \.element.id) { index, concert in
                                                    NavigationLink { ConcertDetailPlaceholderView(concert: concert) } label: {
                                                        HStack(spacing: 14) {
                                                            VStack(alignment: .leading, spacing: 4) {
                                                                Text(concert.concertTitle)
                                                                    .font(.system(size: 18, weight: .bold))
                                                                    .foregroundColor(.black)
                                                                Text(concert.artistName)
                                                                    .font(.system(size: 15, weight: .medium))
                                                                    .foregroundColor(.gray)
                                                                Text([concert.concertDate, concert.concertHall, concert.concertLocation].compactMap { $0 }.joined(separator: " • "))
                                                                    .font(.system(size: 14)).foregroundColor(.gray).lineLimit(1)
                                                            }
                                                            Spacer()
                                                            coverImage(url: concert.coverURL, icon: "music.mic")
                                                            Image(systemName: "chevron.right").foregroundColor(.gray)
                                                        }
                                                        .rowPadding()
                                                    }
                                                    .buttonStyle(.plain)
                                                    if index < filteredConcerts.count - 1 { rowDivider() }
                                                }
                                            }
                                        }

                                        // MARK: Tracks
                                        if selectedFilter == .tracks {
                                            if filteredTracks.isEmpty {
                                                emptyText(searchText.isEmpty ? "Aucune track disponible" : "Aucune track trouvée")
                                            } else {
                                                ForEach(Array(filteredTracks.enumerated()), id: \.element.id) { index, item in
                                                    NavigationLink { ContentView(specificAlbum: item.album) } label: {
                                                        HStack(spacing: 14) {
                                                            VStack(alignment: .leading, spacing: 4) {
                                                                Text(item.track.trackTitle)
                                                                    .font(.system(size: 18, weight: .bold))
                                                                    .foregroundColor(.black)
                                                                Text(item.album.artistName)
                                                                    .font(.system(size: 15, weight: .medium))
                                                                    .foregroundColor(.gray)
                                                                Text(item.album.albumTitle)
                                                                    .font(.system(size: 14)).foregroundColor(.orangeArt).lineLimit(1)
                                                                if let mark = item.track.trackMark {
                                                                    HStack(spacing: 4) {
                                                                        Image(systemName: "star.fill").foregroundColor(.orangeArt)
                                                                        Text("\(mark)").font(.system(size: 15, weight: .bold)).foregroundColor(.black)
                                                                    }
                                                                }
                                                            }
                                                            Spacer()
                                                            coverImage(url: item.album.coverURL, icon: "music.note")
                                                            Image(systemName: "chevron.right").foregroundColor(.gray)
                                                        }
                                                        .rowPadding()
                                                    }
                                                    .buttonStyle(.plain)
                                                    if index < filteredTracks.count - 1 { rowDivider() }
                                                }
                                            }
                                        }

                                        // MARK: Users
                                        if selectedFilter == .users {
                                            if filteredUsers.isEmpty {
                                                emptyText(searchText.isEmpty ? "Aucun utilisateur disponible" : "Aucun utilisateur trouvé")
                                            } else {
                                                ForEach(Array(filteredUsers.enumerated()), id: \.offset) { index, user in
                                                    NavigationLink { OtherUserProfileView(user: user) } label: {
                                                        HStack(spacing: 14) {
                                                            // Avatar
                                                            if let urlString = user.userPic?.first?.imageURL,
                                                               let url = URL(string: urlString) {
                                                                AsyncImage(url: url) { image in
                                                                    image.resizable().scaledToFill()
                                                                } placeholder: {
                                                                    Color.gray.opacity(0.2).overlay(ProgressView())
                                                                }
                                                                .frame(width: 48, height: 48)
                                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                            } else {
                                                                RoundedRectangle(cornerRadius: 12)
                                                                    .fill(Color.gray.opacity(0.2))
                                                                    .frame(width: 48, height: 48)
                                                                    .overlay(Image(systemName: "person.fill").foregroundColor(.gray))
                                                            }

                                                            VStack(alignment: .leading, spacing: 4) {
                                                                HStack(spacing: 4) {
                                                                    Text(user.username)
                                                                        .font(.system(size: 17, weight: .bold))
                                                                        .foregroundColor(.black)
                                                                    if user.certification == true {
                                                                        Image(systemName: "checkmark.seal.fill")
                                                                            .foregroundColor(.orangeArt)
                                                                            .font(.system(size: 13))
                                                                    }
                                                                }
                                                                if let location = user.userLocation {
                                                                    Text(location)
                                                                        .font(.system(size: 14))
                                                                        .foregroundColor(.gray)
                                                                }
                                                                if let followers = user.followers {
                                                                    Text("\(followers) followers")
                                                                        .font(.system(size: 13))
                                                                        .foregroundColor(.secondary)
                                                                }
                                                            }

                                                            Spacer()
                                                            Image(systemName: "chevron.right").foregroundColor(.gray)
                                                        }
                                                        .rowPadding()
                                                    }
                                                    .buttonStyle(.plain)
                                                    if index < filteredUsers.count - 1 { rowDivider() }
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(6)
                                .padding(.bottom, 8)
                                .padding(.horizontal, 18)

                            Spacer(minLength: 100)
//                        }
                    }
                }
            }
//            .navigationBarHidden(true)
            .searchable(text: $searchText, prompt: "Rechercher…")
        }
        .task {
            do {
                //Charge albums en premier
                _ = try await albumVM.fetchAlbums()
                
                //tracks
                try await trackVM.fetchTracks()
                
                //lié
                let albumsById = Dictionary(
                    uniqueKeysWithValues: albumVM.albums.compactMap { album -> (String, Album)? in
                        guard let id = album.recordID else { return nil }
                        return (id, album)
                    }
                )
                
                searchTracks = trackVM.tracks.compactMap { track in
                    guard let albumId = track.linkedAlbums?.first,
                          let album = albumsById[albumId] else { return nil }
                    return SearchTrack(track: track, album: album)
                }
                
                print("searchTracks count: \(searchTracks.count)")
                
                // en parallèle
                async let artists = artistVM.fetchArtists()
                async let concerts = concertVM.fetchConcerts()
                async let users = userVM.fetchUsers()
                _ = try await (artists, concerts, users)
                
            } catch {
                print("Erreur chargement SearchView: \(error)")
            }
        }
    }

    // MARK: - Helpers

    @ViewBuilder
    private func emptyText(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.secondary)
            .padding(.vertical, 32)
    }

    @ViewBuilder
    private func coverImage(url: String?, icon: String) -> some View {
        Group {
            if let urlString = url, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.gray.opacity(0.2))
                        .overlay(ProgressView())
                }
            } else {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.gray.opacity(0.2))
                    .overlay(Image(systemName: icon).foregroundColor(.gray))
            }
        }
        .frame(width: 64, height: 64)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }

    @ViewBuilder
    private func rowDivider() -> some View {
        Divider()
            .padding(.leading, 18)
            .padding(.trailing, 18)
    }
}

private extension View {
    func rowPadding() -> some View {
        self
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
            .contentShape(Rectangle())
    }
}

#Preview {
    SearchView()
}
