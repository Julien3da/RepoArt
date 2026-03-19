//
//  MockDatas.swift
//  GroupeArt
//
//  Created by BlueOneThree on 12/03/2026.
//

import Foundation


//enum HistoryFilter : String, CaseIterable, Identifiable {
//    case tracks = "Morceaux"
//    case albums = "Albums"
//    case artists = "Artistes"
//
//    var id: String { rawValue }
//}

let mockArtists: [FakeArtist] = [
    FakeArtist(
        artistName: "Michael Jackson",
        artistPicture: "mjPic",
        artistDescription: "Chanteur, danseur et icône mondiale de la pop, surnommé le King of Pop."
    ),
    FakeArtist(
        artistName: "The Beatles",
        artistPicture: "beatlesPic",
        artistDescription: "Groupe britannique légendaire qui a révolutionné la musique pop et rock dans les années 60."
    ),
    FakeArtist(
        artistName: "Travis Scott",
        artistPicture: "travisPic",
        artistDescription: "Rappeur et producteur américain connu pour son univers sombre et ses performances énergiques."
    ),
    FakeArtist(
        artistName: "The Weeknd",
        artistPicture: "weekndPic",
        artistDescription: "Artiste canadien mêlant R&B, pop et synthwave avec une esthétique sombre et cinématographique."
    ),
    FakeArtist(
        artistName: "SZA",
        artistPicture: "szaPic",
        artistDescription: "Chanteuse américaine de R&B alternatif reconnue pour ses textes introspectifs et sa voix unique."
    ),
    FakeArtist(
        artistName: "Bruno Mars",
        artistPicture: "brunoPic",
        artistDescription: "Chanteur et performer pop-funk célèbre pour ses hits mondiaux et son style rétro."
    ),
    FakeArtist(
        artistName: "Eagles",
        artistPicture: "eaglesPic",
        artistDescription: "Les Eagles sont un groupe de rock américain emblématique des années 1970, célèbre pour ses harmonies vocales et ses hits comme Hotel California et Take It Easy."
    )
]


let mockTracks: [FakeTrack] = [
    FakeTrack(
        trackTitle: "Come Together",
        trackMark: 4.7,
        trackArtist: mockArtists[1], albumCover: "abbeyRoadCover"),
    FakeTrack(
        trackTitle: "TELEKINESIS(ft.SZA...)",
        trackMark: 4.3,
        trackArtist: mockArtists[2], albumCover: "utopiaCover"),
    FakeTrack(
        trackTitle: "I KNOW ?",
        trackMark: 4.2,
        trackArtist: mockArtists[2], albumCover: "utopiaCover"),
    FakeTrack(
        trackTitle: "Thriller",
        trackMark: 4.8,
        trackArtist: mockArtists[0], albumCover: "thrillerCover"),
    FakeTrack(
        trackTitle: "P.Y.T",
        trackMark: 4.4,
        trackArtist: mockArtists[0], albumCover: "thrillerCover"),
    FakeTrack(
        trackTitle: "Hotel California",
        trackMark: 4.4,
        trackArtist: mockArtists[6], albumCover: "hotelCalCover"),
    FakeTrack(
        trackTitle: "Bad",
        trackMark: 4.7,
        trackArtist: mockArtists[0], albumCover: "badCover"),
]


let mockAlbums: [FakeAlbum] = [
    FakeAlbum(
        albumTitle: "Bad",
        artist: mockArtists[0],
        albumCover: "badCover",
        globalReview: 4.8,
        yearRelease: "1987",
        topReview: nil,
        tracks: [mockTracks[6], mockTracks[4]] // Bad, P.Y.T
    ),
    FakeAlbum(
        albumTitle: "Abbey Road",
        artist: mockArtists[1],
        albumCover: "abbeyRoadCover",
        globalReview: 4.9,
        yearRelease: "1969",
        topReview: nil,
        tracks: [mockTracks[0]] // Come Together
    ),
    FakeAlbum(
        albumTitle: "UTOPIA",
        artist: mockArtists[2],
        albumCover: "utopiaCover",
        globalReview: 4.2,
        yearRelease: "2023",
        topReview: nil,
        tracks: [mockTracks[1], mockTracks[2]] // Telekinesis, I Know ?
    ),
    FakeAlbum(
        albumTitle: "Thriller",
        artist: mockArtists[0],
        albumCover: "thrillerCover",
        globalReview: 4.9,
        yearRelease: "1982",
        topReview: nil,
        tracks: [mockTracks[3]] // Thriller
    ),
    FakeAlbum(
        albumTitle: "SOS",
        artist: mockArtists[4],
        albumCover: "sosCover",
        globalReview: 4.9,
        yearRelease: "2022",
        topReview: nil,
        tracks: []
    ),
    FakeAlbum(
        albumTitle: "Hurry Up Tomorrow",
        artist: mockArtists[3],
        albumCover: "hutCover",
        globalReview: 4.9,
        yearRelease: "2024",
        topReview: nil,
        tracks: []
    )
]

