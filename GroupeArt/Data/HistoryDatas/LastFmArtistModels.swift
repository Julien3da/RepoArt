//
//  LastFmArtistModels.swift
//  GroupeArt
//
//  Created by FUVE on 12/03/2026.
//

import Foundation

struct LastFmTopArtistsResponse: Codable {
    let topartists: LastFmTopArtists
}

struct LastFmTopArtists: Codable {
    let artist: [LastFmArtistInfo]
}

struct LastFmArtistInfo: Codable, Identifiable {
    var id: String { name }
    let name: String
    let url: String
    let image: [LastFmImage]
    let bio: LastFmBio?

    var wikipediaImageURL: URL? = nil
    var wikipediaBio: String? = nil

    private enum CodingKeys: String, CodingKey {
        case name, url, image, bio
    }
}

struct LastFmBio: Codable {
    let summary: String
}
