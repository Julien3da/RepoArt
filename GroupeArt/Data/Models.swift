//
//  Models.swift
//  GroupeArt
//
//  Created by Matt et Nico on 05/03/2026.
//

import Foundation


// devrait être une class ???

// et aussi ne faut-il pas créer une struct Artiste, pour différencier les utilisateurs, comme une page pro qui est
// faite pour publier des albums/singles...
struct User: Identifiable {
    var id = UUID()
    let username: String
    let userPic: String?
    var certification: Bool
    let userLocation: String?
    var followers: Int
    var following: Int
    var countReviews: Int
    let bio: String?
}

struct Artist: Identifiable {
    var id = UUID()
    let artistName: String
    let artistCover: String
    let artistPicture: String
    var artistDescription: String
}

struct Album: Identifiable {
    var id = UUID()
    let albumTitle: String
    let artist: Artist
    let albumCover: String
    let globalReview: Double
    let yearRelease: String
    var topReview: Review?
    var tracks: [Track]
}

struct Track: Identifiable {
    var id = UUID()
    let trackTitle: String
    var trackMark: Double
    let trackArtist: Artist
    let albumCover: String
}

//utilisable et pour les concerts et pour les albums
struct Review: Identifiable {
    var id = UUID()
    var reviewTitle: String
    var mark: Double
    var user : User
    var userReview: String
}

struct Concert: Identifiable {
    var id = UUID()
    let concertTitle: String
    let artist: Artist
    let concertCover: String
    let globalReview: Double
    let concertDate: String
    let concertLocation: String
}
