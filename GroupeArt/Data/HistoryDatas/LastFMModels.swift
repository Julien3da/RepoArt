//
//  LastFMModels.swift
//  GroupeArt
//
//  Created by BlueOneThree on 12/03/2026.
//

import Foundation

struct LastFmResponse: Codable {
    let recenttracks: LastFmRecentTracks
}

struct LastFmRecentTracks: Codable {
    let track: [LastFmTrack]
}

struct LastFmTrack: Codable, Identifiable {
    var id: String { url }
    let name: String
    let url: String
    let artist: LastFmArtist
    let album: LastFmAlbum
    let image: [LastFmImage]

    var coverURL: URL? {
        guard let urlString = image.last?.text, !urlString.isEmpty else { return nil }
        return URL(string: urlString)
    }
}

struct LastFmArtist: Codable {
    let text: String

    private enum CodingKeys: String, CodingKey {
        case text = "#text"
    }
}

struct LastFmAlbum: Codable {
    let text: String

    private enum CodingKeys: String, CodingKey {
        case text = "#text"
    }
}

struct LastFmImage: Codable {
    let text: String
    let size: String

    private enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size
    }
}
