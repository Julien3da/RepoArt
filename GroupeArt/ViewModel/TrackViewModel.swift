//
//  TrackViewModel.swift
//  GroupeArt
//
//  Created by apprenant84 on 10/03/2026.
//

import Foundation
import Observation

@Observable @MainActor
class TrackViewModel {
    private let apiKey: String =
            "patOE0Bk62hEWC6uu.2463aca8589573d9a241d1f41caee3651b50c658023d5bfaa2092de96a1894f3"
        private let baseURL = URL(
            string: "https://api.airtable.com/v0/appfvBclieq9JmBZF/Track"
        )!
    
    var tracks: [Track] = []

    func fetchTracks() async throws {
        var request = URLRequest(url: baseURL)
                request.httpMethod = "GET"
                request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

                let (data, _) = try await URLSession.shared.data(for: request)

                // Debug: inspect raw JSON keys
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let records = json["records"] as? [[String: Any]],
                       let first = records.first,
                       let fields = first["fields"] as? [String: Any] {
                        print("[Debug] Track API first record fields keys: \(fields.keys)")
                    }
                } catch {
                    print("[Debug] JSON parse error (Track): \(error)")
                }

                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601

                do {
                    let decoded = try decoder.decode(TrackReponse.self, from: data)
                    let tracks = decoded.records.map { $0.fields }
                    self.tracks = tracks
                } catch {
                    print("Échec du décodage: \(error)")
                    throw error
                }
        
    }
}
