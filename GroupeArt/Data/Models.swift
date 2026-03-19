//
//  Models.swift
//  GroupeArt
//
//  Created by Matt et Nico on 05/03/2026.
//

import Foundation


// MARK: - Airtable Attachment (images)

struct AirtableThumbnail: Codable {
    let url: String
    let width: Int?
    let height: Int?
}

struct AirtableThumbnails: Codable {
    let small: AirtableThumbnail?
    let large: AirtableThumbnail?
    let full: AirtableThumbnail?
}

struct AirtableAttachment: Codable {
    let url: String
    let filename: String?
    let thumbnails: AirtableThumbnails?

    /// URL optimisée : thumbnail large si dispo, sinon URL originale
    var imageURL: String {
        thumbnails?.large?.url ?? url
    }
}


// MARK: - Airtable Response Wrappers

struct UserReponse: Codable {
    let records: [UserResult]
}
struct UserResult: Codable {
    let id: String //Niconni a ajouté
    let fields: User
}

struct ArtistReponse: Codable {
    let records: [ArtistResult]
}
struct ArtistResult: Codable {
    let fields: Artist
}

struct AlbumReponse: Codable {
    let records: [AlbumResult]
}
struct AlbumResult: Codable {
    let id: String 
    let fields: Album
}

struct TrackReponse: Codable {
    let id: String
    let records: [TrackResult]
}
struct TrackResult: Codable {
    let id: String
    let fields: Track
}

struct ReviewReponse: Codable {
    let records: [ReviewResult]
}
struct ReviewResult: Codable {
    let id: String //Niconni a ajouté
    let fields: Review
}

struct ConcertReponse: Codable {
    let records: [ConcertResult]
}
struct ConcertResult: Codable {
    let fields: Concert
}


// MARK: - User

struct User: Identifiable, Codable {
    var id = UUID()
    var recordId: String? = nil
    var username: String
    var userPic : [AirtableAttachment]?
    var certification: Bool?
    var userLocation: String?
    var followers: Int?
    var following: Int?
    var countReviews: Int?
    var bio: String?

    private enum CodingKeys: String, CodingKey {
        case username, userPic, certification, userLocation, followers, following, countReviews, bio
    }
}


// MARK: - Artist

struct Artist: Identifiable, Codable {
    var id = UUID()
    var artistName: String = "Artiste inconnu"
    var artistDescription: String? = nil
    var artistPicture: [AirtableAttachment]? = nil

    var pictureURL: String? {
        artistPicture?.first?.imageURL
    }

    private enum CodingKeys: String, CodingKey {
        case artistName, artistDescription, artistPicture
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.artistName = (try? container.decode(String.self, forKey: .artistName)) ?? "Artiste inconnu"
        self.artistDescription = try? container.decode(String.self, forKey: .artistDescription)
        self.artistPicture = try? container.decode([AirtableAttachment].self, forKey: .artistPicture)
    }

    init(artistName: String = "Artiste inconnu", artistDescription: String? = nil) {
        self.artistName = artistName
        self.artistDescription = artistDescription
    }
}


// MARK: - Album
// Airtable renvoie les champs liés à l'artiste en flat :
//   "artistName (from Artist)": ["Daft Punk"]
//   "mark (from topReview)": [5, 2]

struct Album: Identifiable, Codable {
    var id = UUID()
    var recordID: String? 
    var albumTitle: String = "Sans titre"
    var yearRelease: String? = nil
    var artistNameFromArtist: [String]? = nil
    var markFromTopReview: [Int]? = nil
    var reviewTitleFromTopReview: [String]? = nil
    var userReviewFromTopReview: [String]? = nil
    var usernameFromTopReview: [String]? = nil
    var trackMarkFromTracks: [Int]? = nil
    var trackTitleFromTracks: [String]? = nil
    var tracks: [String]? = nil // IDs des records Track liés, pour l'ordre
    var albumCover: [AirtableAttachment]? = nil
    var artistPictureFromArtist: [AirtableAttachment]? = nil

    // Computed helpers pour l'affichage
    var artistName: String {
        artistNameFromArtist?.first ?? "Artiste inconnu"
    }

    var globalReview: Double {
        guard let marks = markFromTopReview, !marks.isEmpty else { return 0.0 }
        return Double(marks.reduce(0, +)) / Double(marks.count)
    }

    var coverURL: String? {
        albumCover?.first?.imageURL
    }

    var artistPicURL: String? {
        artistPictureFromArtist?.first?.imageURL
    }

    private enum CodingKeys: String, CodingKey {
        case albumTitle
        case yearRelease
        case artistNameFromArtist = "artistName (from Artist)"
        case markFromTopReview = "mark (from topReview)"
        case reviewTitleFromTopReview = "reviewTitle (from topReview)"
        case userReviewFromTopReview = "userReview (from topReview)"
        case usernameFromTopReview = "username (from user) (from topReview)"
        case trackMarkFromTracks = "trackMark (from tracks)"
        case trackTitleFromTracks = "trackTitle (from tracks)"
        case tracks // Assume field name "tracks" (lowercase) matches the lookup source
        case albumCover
        case artistPictureFromArtist = "artistPicture (from Artist)"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.albumTitle = (try? container.decode(String.self, forKey: .albumTitle)) ?? "Sans titre"
        self.yearRelease = try? container.decode(String.self, forKey: .yearRelease)
        self.artistNameFromArtist = try? container.decode([String].self, forKey: .artistNameFromArtist)
        self.markFromTopReview = try? container.decode([Int].self, forKey: .markFromTopReview)
        self.reviewTitleFromTopReview = try? container.decode([String].self, forKey: .reviewTitleFromTopReview)
        self.userReviewFromTopReview = try? container.decode([String].self, forKey: .userReviewFromTopReview)
        self.usernameFromTopReview = try? container.decode([String].self, forKey: .usernameFromTopReview)
        self.trackMarkFromTracks = try? container.decode([Int].self, forKey: .trackMarkFromTracks)
        self.trackTitleFromTracks = try? container.decode([String].self, forKey: .trackTitleFromTracks)
        self.tracks = try? container.decode([String].self, forKey: .tracks)
        self.albumCover = try? container.decode([AirtableAttachment].self, forKey: .albumCover)
        self.artistPictureFromArtist = try? container.decode([AirtableAttachment].self, forKey: .artistPictureFromArtist)
    }

   
}


// MARK: - Track

struct Track: Identifiable, Codable {
    var recordID: String? = nil
    var id: String = ""
    let trackTitle: String
    let trackMark: Int?
    
    let trackArtist: [String]?
    var linkedAlbums: [String]? // IDs des albums liés (table Album)
    let albumCoverFromAlbum: [AirtableAttachment]?
    
    var artistName: String {
        guard let first = trackArtist?.first else {
            return "Artiste inconnu"
        }
        
        if first.starts(with: "rec") {
            return "Artiste inconnu"
        }
        
        return first
    }
    
    var coverURL: String? {
        albumCoverFromAlbum?.first?.url
    }
    
    private enum CodingKeys: String, CodingKey {
        case trackTitle
        case trackMark
        case trackArtist
        case albumCoverFromAlbum = "albumCover (from albumCover)"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trackTitle = try container.decode(String.self, forKey: .trackTitle)
        self.trackMark = try container.decodeIfPresent(Int.self, forKey: .trackMark)
        self.trackArtist = try container.decodeIfPresent([String].self, forKey: .trackArtist)
        self.albumCoverFromAlbum = try? container.decode([AirtableAttachment].self, forKey: .albumCoverFromAlbum)
    }
    
}


// MARK: - Review

struct Review: Identifiable, Codable {
    var recordId: String? = nil
    var id: String = ""
    let reviewTitle: String?
    let markReview: Int?
    let userReview: String?
    let usernameFromUser: [String]?
    
    let album: [String]?
    let track: [String]?
    
    var username: String {
        usernameFromUser?.first ?? "Anonyme"
    }
    
    private enum CodingKeys: String, CodingKey {
        case reviewTitle, markReview, userReview
        case usernameFromUser = "username (from user)"
        case album = "Album"
        case track = "Track"
    }
}



// MARK: - Concert

struct Concert: Identifiable, Codable {
    var id = UUID()
    var concertTitle: String = "Sans titre"
    var concertDate: String? = nil
    var concertLocation: String? = nil
    var concertHall: String? = nil
    var artistNameFromArtist: [String]? = nil
    var concertCover: [AirtableAttachment]? = nil
    
    var artistName: String {
        artistNameFromArtist?.first ?? "Artiste inconnu"
    }

    var coverURL: String? {
        concertCover?.first?.imageURL
    }
    
    private enum CodingKeys: String, CodingKey {
        case concertTitle, concertDate, concertLocation, concertHall, concertCover
        case artistNameFromArtist = "artistName (from artist)"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        self.concertTitle = (try? c.decode(String.self, forKey: .concertTitle)) ?? "Sans titre"
        self.concertDate = try? c.decode(String.self, forKey: .concertDate)
        self.concertLocation = try? c.decode(String.self, forKey: .concertLocation)
        self.concertHall = try? c.decode(String.self, forKey: .concertHall)
        self.artistNameFromArtist = try? c.decode([String].self, forKey: .artistNameFromArtist)
        self.concertCover = try? c.decode([AirtableAttachment].self, forKey: .concertCover)
    }

    init(concertTitle: String = "Sans titre", concertDate: String? = nil, concertLocation: String? = nil, concertHall: String? = nil, artistNameFromArtist: [String]? = nil) {
        self.concertTitle = concertTitle
        self.concertDate = concertDate
        self.concertLocation = concertLocation
        self.concertHall = concertHall
        self.artistNameFromArtist = artistNameFromArtist
    }
}
