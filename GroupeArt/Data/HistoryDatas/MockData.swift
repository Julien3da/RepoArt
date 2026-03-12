////
////  MockData.swift
////  GroupeArt
////
////  Created by FUVE on 06/03/2026.
////
//// Fake datas
//
////import Foundation
//
//enum HistoryFilter : String, CaseIterable, Identifiable {
//    case tracks = "Morceaux"
//    case albums = "Albums"
//    case artists = "Artistes"
//    
//    var id: String { rawValue }
//}
//
//<<<<<<< HEAD
//let mockArtists: [Artist] = [
//    Artist(
//        artistName: "Michael Jackson",
//        artistCover: "mjPic",
//        artistPicture: "mjPic",
//        artistDescription: "Chanteur, danseur et icône mondiale de la pop, surnommé le King of Pop."
//    ),
//    Artist(
//        artistName: "The Beatles",
//        artistCover: "beatlesPic",
//        artistPicture: "beatlesPic",
//        artistDescription: "Groupe britannique légendaire qui a révolutionné la musique pop et rock dans les années 60."
//    ),
//    Artist(
//        artistName: "Travis Scott",
//        artistCover: "travisPic",
//        artistPicture: "travisPic",
//        artistDescription: "Rappeur et producteur américain connu pour son univers sombre et ses performances énergiques."
//    ),
//    Artist(
//        artistName: "The Weeknd",
//        artistCover: "weekndPic",
//        artistPicture: "weekndPic",
//        artistDescription: "Artiste canadien mêlant R&B, pop et synthwave avec une esthétique sombre et cinématographique."
//    ),
//    Artist(
//        artistName: "SZA",
//        artistCover: "szaPic",
//        artistPicture: "szaPic",
//        artistDescription: "Chanteuse américaine de R&B alternatif reconnue pour ses textes introspectifs et sa voix unique."
//    ),
//    Artist(
//        artistName: "Bruno Mars",
//        artistCover: "brunoPic",
//        artistPicture: "brunoPic",
//        artistDescription: "Chanteur et performer pop-funk célèbre pour ses hits mondiaux et son style rétro."
//    )
//]
//
//
//let mockTracks: [Track] = [
//    Track(
//        trackTitle: "Come Together",
//        trackMark: 4.7,
//        trackArtist: mockArtists[1], albumCover: "abbeyRoadCover"),
//    Track(
//        trackTitle: "TELEKINESIS(ft.SZA...)",
//        trackMark: 4.3,
//        trackArtist: mockArtists[2], albumCover: "utopiaCover"),
//    Track(
//        trackTitle: "I KNOW ?",
//        trackMark: 4.2,
//        trackArtist: mockArtists[2], albumCover: "utopiaCover"),
//    Track(
//        trackTitle: "Thriller",
//        trackMark: 4.8,
//        trackArtist: mockArtists[0], albumCover: "thrillerCover"),
//    Track(
//        trackTitle: "P.Y.T",
//        trackMark: 4.4,
//        trackArtist: mockArtists[0], albumCover: "thrillerCover"),
//    Track(
//        trackTitle: "Hotel California",
//        trackMark: 4.4,
//        trackArtist: Artist(artistName: "Eagles", artistCover: "hotelCalCover", artistPicture: "eaglesPic", artistDescription: "..."), albumCover: "hotelCalCover"),
//    Track(
//        trackTitle: "Bad",
//        trackMark: 4.7,
//        trackArtist: mockArtists[0], albumCover: "badCover"),
//]
//
//
//let mockAlbums: [Album] = [
//    Album(
//        albumTitle: "Bad",
//        artist: mockArtists[0],
//        albumCover: "badCover",
//        globalReview: 4.8,
//        yearRelease: "1987",
//        topReview: nil,
//        tracks: [mockTracks[6], mockTracks[4]] // Bad, P.Y.T
//    ),
//    Album(
//        albumTitle: "Abbey Road",
//        artist: mockArtists[1],
//        albumCover: "abbeyRoadCover",
//        globalReview: 4.9,
//        yearRelease: "1969",
//        topReview: nil,
//        tracks: [mockTracks[0]] // Come Together
//    ),
//    Album(
//        albumTitle: "UTOPIA",
//        artist: mockArtists[2],
//        albumCover: "utopiaCover",
//        globalReview: 4.2,
//        yearRelease: "2023",
//        topReview: nil,
//        tracks: [mockTracks[1], mockTracks[2]] // Telekinesis, I Know ?
//    ),
//    Album(
//        albumTitle: "Thriller",
//        artist: mockArtists[0],
//        albumCover: "thrillerCover",
//        globalReview: 4.9,
//        yearRelease: "1982",
//        topReview: nil,
//        tracks: [mockTracks[3]] // Thriller
//    ),
//    Album(
//        albumTitle: "SOS",
//        artist: mockArtists[4],
//        albumCover: "sosCover",
//        globalReview: 4.9,
//        yearRelease: "2022",
//        topReview: nil,
//        tracks: []
//    ),
//    Album(
//        albumTitle: "Hurry Up Tomorrow",
//        artist: mockArtists[3],
//        albumCover: "hutCover",
//        globalReview: 4.9,
//        yearRelease: "2024",
//        topReview: nil,
//        tracks: []
//    )
//]
//=======
// Fake datas

import Foundation

enum HistoryFilter : String, CaseIterable, Identifiable {
    case tracks = "Morceaux"
    case albums = "Albums"
    case artists = "Artistes"
    
    var id: String { rawValue }
}

let mockArtists: [Artist] = [
    Artist(
        artistName: "Michael Jackson",
        artistPicture: "mjPic",
        artistDescription: "Chanteur, danseur et icône mondiale de la pop, surnommé le King of Pop."
    ),
    Artist(
        artistName: "The Beatles",
        artistPicture: "beatlesPic",
        artistDescription: "Groupe britannique légendaire qui a révolutionné la musique pop et rock dans les années 60."
    ),
    Artist(
        artistName: "Travis Scott",
        artistPicture: "travisPic",
        artistDescription: "Rappeur et producteur américain connu pour son univers sombre et ses performances énergiques."
    ),
    Artist(
        artistName: "The Weeknd",
        artistPicture: "weekndPic",
        artistDescription: "Artiste canadien mêlant R&B, pop et synthwave avec une esthétique sombre et cinématographique."
    ),
    Artist(
        artistName: "SZA",
        artistPicture: "szaPic",
        artistDescription: "Chanteuse américaine de R&B alternatif reconnue pour ses textes introspectifs et sa voix unique."
    ),
    Artist(
        artistName: "Bruno Mars",
        artistPicture: "brunoPic",
        artistDescription: "Chanteur et performer pop-funk célèbre pour ses hits mondiaux et son style rétro."
    )
]


let mockTracks: [Track] = [
    Track(
        trackTitle: "Come Together",
        trackMark: 4.7,
        trackArtist: mockArtists[1], albumCover: "abbeyRoadCover"),
    Track(
        trackTitle: "TELEKINESIS(ft.SZA...)",
        trackMark: 4.3,
        trackArtist: mockArtists[2], albumCover: "utopiaCover"),
    Track(
        trackTitle: "I KNOW ?",
        trackMark: 4.2,
        trackArtist: mockArtists[2], albumCover: "utopiaCover"),
    Track(
        trackTitle: "Thriller",
        trackMark: 4.8,
        trackArtist: mockArtists[0], albumCover: "thrillerCover"),
    Track(
        trackTitle: "P.Y.T",
        trackMark: 4.4,
        trackArtist: mockArtists[0], albumCover: "thrillerCover"),
    Track(
        trackTitle: "Hotel California",
        trackMark: 4.4,
        trackArtist: Artist(artistName: "Eagles", artistPicture: "eaglesPic", artistDescription: "..."), albumCover: "hotelCalCover"),
    Track(
        trackTitle: "Bad",
        trackMark: 4.7,
        trackArtist: mockArtists[0], albumCover: "badCover"),
]


let mockAlbums: [Album] = [
    Album(
        albumTitle: "Bad",
        artist: mockArtists[0],
        albumCover: "badCover",
        globalReview: 4.8,
        yearRelease: "1987",
        topReview: nil,
        tracks: [mockTracks[6], mockTracks[4]] // Bad, P.Y.T
    ),
    Album(
        albumTitle: "Abbey Road",
        artist: mockArtists[1],
        albumCover: "abbeyRoadCover",
        globalReview: 4.9,
        yearRelease: "1969",
        topReview: nil,
        tracks: [mockTracks[0]] // Come Together
    ),
    Album(
        albumTitle: "UTOPIA",
        artist: mockArtists[2],
        albumCover: "utopiaCover",
        globalReview: 4.2,
        yearRelease: "2023",
        topReview: nil,
        tracks: [mockTracks[1], mockTracks[2]] // Telekinesis, I Know ?
    ),
    Album(
        albumTitle: "Thriller",
        artist: mockArtists[0],
        albumCover: "thrillerCover",
        globalReview: 4.9,
        yearRelease: "1982",
        topReview: nil,
        tracks: [mockTracks[3]] // Thriller
    ),
    Album(
        albumTitle: "SOS",
        artist: mockArtists[4],
        albumCover: "sosCover",
        globalReview: 4.9,
        yearRelease: "2022",
        topReview: nil,
        tracks: []
    ),
    Album(
        albumTitle: "Hurry Up Tomorrow",
        artist: mockArtists[3],
        albumCover: "hutCover",
        globalReview: 4.9,
        yearRelease: "2024",
        topReview: nil,
        tracks: []
    )
]
//>>>>>>> main
