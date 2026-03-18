//
//  AlbumViewModel.swift
//  GroupeArt
//
//  Created by apprenant84 on 10/03/2026.
//

import Foundation
import Observation

@Observable @MainActor
class AlbumViewModel {
    private let apiKey = "patOE0Bk62hEWC6uu.2463aca8589573d9a241d1f41caee3651b50c658023d5bfaa2092de96a1894f3"
    private let baseURL = URL(string: "https://api.airtable.com/v0/appfvBclieq9JmBZF/Album")!

    var albums: [Album] = []
    var randomAlbum: Album?
    var albumTracks: [Track] = []

    private func makeRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        return request
    }

    func fetchAlbums() async throws -> [Album] {
        let (data, _) = try await URLSession.shared.data(for: makeRequest(url: baseURL))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let decoded = try decoder.decode(AlbumReponse.self, from: data)
            let albums = decoded.records.map { record -> Album in
                var album = record.fields
                album.recordId = record.id
                album.id = record.id
                return album
            }.filter { $0.albumTitle != "Sans titre" }
            self.albums = albums
            return albums
        } catch {
            print("Échec du décodage: \(error)")
            throw error
        }
    }

    func fetchRandomAlbum() async throws {
        let albums = try await fetchAlbums()
        let richAlbums = albums.filter {
            ($0.trackMarkFromTracks?.count ?? 0) > 0 &&
            ($0.reviewTitleFromTopReview?.count ?? 0) > 0
        }
        self.randomAlbum = richAlbums.randomElement() ?? albums.first
    }

    func fetchTracksForAlbum() async throws {
        let trackURL = URL(string: "https://api.airtable.com/v0/appfvBclieq9JmBZF/Track")!
        let (data, _) = try await URLSession.shared.data(for: makeRequest(url: trackURL))
        let decoded = try JSONDecoder().decode(TrackReponse.self, from: data)
        self.albumTracks = decoded.records.map { record -> Track in
            var track = record.fields
            track.recordId = record.id
            return track
        }
    }
}
