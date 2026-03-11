//
//  Models.swift
//  GroupeArt
//
//  Created by Matt et Nico on 05/03/2026.
//

import Foundation


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
}

struct Artist: Identifiable, Codable {
    var id = UUID()
    let artistName: String
    let artistPicture: String
    var artistDescription: String
}

struct Album: Identifiable, Codable {
    var id = UUID()
    let albumTitle: String
    let artist: Artist
    let albumCover: String
    let globalReview: Double
    let yearRelease: String // changer en Date
    var topReview: Review?
    var tracks: [Track]
}

struct Track: Identifiable, Codable {
    var id = UUID()
    let trackTitle: String
    var trackMark: Double
    let trackArtist: Artist
    let albumCover: String
}

//utilisable et pour les concerts et pour les albums
struct Review: Identifiable, Codable {
    var id = UUID()
    var reviewTitle: String
    var markReview: Double
    var user : User
    var userReview: String
}

struct Concert: Identifiable, Codable {
    var id = UUID()
    let concertTitle: String
    let artist: Artist
    let concertCover: String
    let globalReview: Double
    let concertDate: String // changer en Date
    let concertLocation: String
    let concertHall: String
}
// commentaire
