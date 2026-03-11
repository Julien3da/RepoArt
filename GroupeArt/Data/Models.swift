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
struct UserReponse: Codable {
    let records: [UserResult]
}
struct UserResult: Codable {
    let fields: User
}

struct User: Identifiable, Codable {
    var id = UUID()
    let username: String
    let userPic: String?
    var certification: Bool
    let userLocation: String?
    var followers: Int
    var following: Int
    var countReviews: Int
    let bio: String?
    
    private enum CodingKeys: String, CodingKey {
        case username
        case userPic
        case certification
        case userLocation
        case followers
        case following
        case countReviews
        case bio
    }
}

struct ArtistReponse: Codable {
    let records: [ArtistResult]
}
struct ArtistResult: Codable {
    let fields: Artist
}

struct Artist: Identifiable, Codable {
    var id = UUID()
    let artistName: String
    let artistPicture: String
    var artistDescription: String
    
    private enum CodingKeys: String, CodingKey {
        case artistName
        case artistPicture
        case artistDescription
    }
}

struct AlbumReponse: Codable {
    let records: [AlbumResult]
}
struct AlbumResult: Codable {
    let fields: Album
}

struct Album: Identifiable, Codable {
    var id = UUID()
    let albumTitle: String
    let artist: Artist
    let albumCover: String
    let globalReview: Double
    let yearRelease: String
    var topReview: Review?
    var tracks: [Track]
    
    private enum CodingKeys: String, CodingKey {
        case albumTitle
        case artist
        case albumCover
        case globalReview
        case yearRelease
        case topReview
        case tracks
    }
}

struct TrackReponse: Codable {
    let records: [TrackResult]
}
struct TrackResult: Codable {
    let fields: Track
}

struct Track: Identifiable, Codable {
    var id = UUID()
    let trackTitle: String
    var trackMark: Double
    let trackArtist: Artist
    let albumCover: String
    
    private enum CodingKeys: String, CodingKey {
        case trackTitle
        case trackMark
        case trackArtist
        case albumCover
    }
}

struct ReviewReponse: Codable {
    let records: [ReviewResult]
}
struct ReviewResult: Codable {
    let fields: Review
}

//utilisable et pour les concerts et pour les albums
struct Review: Identifiable, Codable {
    var id = UUID()
    var reviewTitle: String
    var markReview: Double
    var user : User
    var userReview: String
    
    private enum CodingKeys: String, CodingKey {
        case reviewTitle
        case markReview
        case user
        case userReview
    }
}

struct ConcertReponse: Codable {
    let records: [ConcertResult]
}
struct ConcertResult: Codable {
    let fields: Concert
}

struct Concert: Identifiable, Codable {
    var id = UUID()
    let concertTitle: String
    let artist: Artist
    let concertCover: String
    let globalReview: Double
    let concertDate: String
    let concertLocation: String
    let concertHall: String
}
