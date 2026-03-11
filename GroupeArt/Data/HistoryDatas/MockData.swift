//
//  MockData.swift
//  GroupeArt
//
//  Created by FUVE on 06/03/2026.
//
// Fake datas

import Foundation

enum HistoryFilter : String, CaseIterable, Identifiable {
    case tracks = "Morceaux"
    case albums = "Albums"
    case artists = "Artistes"
    
    var id: String { rawValue }
}

let mockArtists: [Artist] = [
    Artist(artistName: "Michael Jackson", artistDescription: "Chanteur, danseur et icône mondiale de la pop, surnommé le King of Pop."),
    Artist(artistName: "The Beatles", artistDescription: "Groupe britannique légendaire qui a révolutionné la musique pop et rock dans les années 60."),
    Artist(artistName: "Travis Scott", artistDescription: "Rappeur et producteur américain connu pour son univers sombre et ses performances énergiques."),
    Artist(artistName: "The Weeknd", artistDescription: "Artiste canadien mêlant R&B, pop et synthwave avec une esthétique sombre et cinématographique."),
    Artist(artistName: "SZA", artistDescription: "Chanteuse américaine de R&B alternatif reconnue pour ses textes introspectifs et sa voix unique."),
    Artist(artistName: "Bruno Mars", artistDescription: "Chanteur et performer pop-funk célèbre pour ses hits mondiaux et son style rétro.")
]

let mockTracks: [Track] = [
    Track(trackTitle: "Come Together", trackMark: 5),
    Track(trackTitle: "TELEKINESIS(ft.SZA...)", trackMark: 4),
    Track(trackTitle: "I KNOW ?", trackMark: 4),
    Track(trackTitle: "Thriller", trackMark: 5),
    Track(trackTitle: "P.Y.T", trackMark: 4),
    Track(trackTitle: "Hotel California", trackMark: 4),
    Track(trackTitle: "Bad", trackMark: 5),
]

let mockAlbums: [Album] = [
    Album(albumTitle: "Bad", yearRelease: "1987", artistNameFromArtist: ["Michael Jackson"], markFromTopReview: [5]),
    Album(albumTitle: "Abbey Road", yearRelease: "1969", artistNameFromArtist: ["The Beatles"], markFromTopReview: [5]),
    Album(albumTitle: "UTOPIA", yearRelease: "2023", artistNameFromArtist: ["Travis Scott"], markFromTopReview: [4]),
    Album(albumTitle: "Thriller", yearRelease: "1982", artistNameFromArtist: ["Michael Jackson"], markFromTopReview: [5]),
    Album(albumTitle: "SOS", yearRelease: "2022", artistNameFromArtist: ["SZA"], markFromTopReview: [5]),
    Album(albumTitle: "Hurry Up Tomorrow", yearRelease: "2024", artistNameFromArtist: ["The Weeknd"], markFromTopReview: [5]),
]
