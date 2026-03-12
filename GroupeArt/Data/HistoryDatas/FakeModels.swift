//
//  FakeModels.swift
//  GroupeArt
//
//  Created by FUVE on 12/03/2026.
//

import Foundation

struct FakeUser: Identifiable {
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

struct FakeArtist: Identifiable{
    var id = UUID()
    let artistName: String
    let artistPicture: String
    var artistDescription: String
}

struct FakeAlbum: Identifiable {
    var id = UUID()
    let albumTitle: String
    let artist: FakeArtist
    let albumCover: String
    let globalReview: Double

    let yearRelease: String // changer en Date
    var topReview: FakeReview?
    var tracks: [FakeTrack]
}


struct FakeTrack: Identifiable {
    var id = UUID()
    let trackTitle: String
    var trackMark: Double
    let trackArtist: FakeArtist
    let albumCover: String
}


struct FakeReview: Identifiable {
    var id = UUID()
    var reviewTitle: String
    var markReview: Double
    var user : FakeUser
    var userReview: String
}

struct FakeConcert: Identifiable {
    var id = UUID()
    let concertTitle: String
    let artist: FakeArtist
    let concertCover: String
    let globalReview: Double
    let concertDate: String
    let concertLocation: String
    let concertHall: String
}

