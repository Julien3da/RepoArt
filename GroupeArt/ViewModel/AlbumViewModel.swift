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
    private let apiKey: String =
            "patOE0Bk62hEWC6uu.2463aca8589573d9a241d1f41caee3651b50c658023d5bfaa2092de96a1894f3"
        private let baseURL = URL(
            string: "https://api.airtable.com/v0/appfvBclieq9JmBZF/Album"
        )!
    
    var albums: [Album] = []
    var randomAlbum: Album?
    var albumTracks: [Track] = []
    
    func fetchAlbums() async throws -> [Album] {
        var request = URLRequest(url: baseURL)
                request.httpMethod = "GET"
                request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

                let (data, _) = try await URLSession.shared.data(for: request)

                // Debug: inspect raw JSON keys to see how Airtable renvoie les champs liés
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let records = json["records"] as? [[String: Any]],
                       let first = records.first,
                       let fields = first["fields"] as? [String: Any] {
                        print("[Debug] Album API first record fields keys: \(fields.keys)")
                        if let t = fields["trackTitle (from tracks)"] {
                            print("[Debug] Found trackTitle (from tracks): \(t)")
                        } else if let t2 = fields["trackTitle (from Track)"] {
                            print("[Debug] Found trackTitle (from Track): \(t2)")
                        } else if let t3 = fields["trackTitle (from Tracks)"] {
                            print("[Debug] Found trackTitle (from Tracks): \(t3)")
                        }
                    }
                } catch {
                    print("[Debug] JSON parse error: \(error)")
                }

                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601

                do {
                    let decoded = try decoder.decode(AlbumReponse.self, from: data)
                    let albums = decoded.records.compactMap { record -> Album? in
                        var album = record.fields
                        album.airtableID = record.id
                        return album.albumTitle != "Sans titre" ? album : nil
                    }
                    self.albums = albums

                    // Debug: print track titles for each album decoded
                    for a in albums {
                        print("[Debug] Album \(a.albumTitle) -> trackTitleFromTracks: \(a.trackTitleFromTracks ?? [])")
                    }

                    return albums
                } catch {
                    print("Échec du décodage: \(error)")
                    throw error
                }
    }
    
    func fetchRandomAlbum() async throws {
        let albums = try await fetchAlbums()
        // Prendre un album au hasard qui a des tracks ET des reviews
        let richAlbums = albums.filter {
            ($0.trackMarkFromTracks?.count ?? 0) > 0 &&
            ($0.reviewTitleFromTopReview?.count ?? 0) > 0
        }
        self.randomAlbum = richAlbums.randomElement() ?? albums.first
    }
    
    func fetchTracksForAlbum() async throws {
        let trackURL = URL(string: "https://api.airtable.com/v0/appfvBclieq9JmBZF/Track")!
        var allTracks: [Track] = []
        var offset: String? = nil
        
        repeat {
            var components = URLComponents(url: trackURL, resolvingAgainstBaseURL: true)!
            if let offset = offset {
                components.queryItems = [URLQueryItem(name: "offset", value: offset)]
            }
            
            var request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            
            // Structure temporaire pour récupérer l'offset
            struct PagedTrackResponse: Codable {
                let records: [TrackResult]
                let offset: String?
            }
            
            let decoded = try decoder.decode(PagedTrackResponse.self, from: data)
            let pageTracks = decoded.records.map { record -> Track in
                var track = record.fields
                track.airtableID = record.id
                return track
            }
            allTracks.append(contentsOf: pageTracks)
            offset = decoded.offset
            
        } while offset != nil
        
        self.albumTracks = allTracks
    }
}
