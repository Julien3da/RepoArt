//
//  ArtistViewModel.swift
//  GroupeArt
//
//  Created by apprenant84 on 10/03/2026.
//

import Foundation
import Observation

@Observable @MainActor
class ArtistViewModel {
    private let apiKey: String =
    "patOE0Bk62hEWC6uu.2463aca8589573d9a241d1f41caee3651b50c658023d5bfaa2092de96a1894f3"
    private let baseURL = URL(
        string: "https://api.airtable.com/v0/appfvBclieq9JmBZF/Artist"
    )!
    
    var artists: [Artist] = []
    
    func fetchArtists() async throws -> [Artist] {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let decoded = try decoder.decode(ArtistReponse.self, from: data)
            
            let artists = decoded.records.map { record -> Artist in
                var artist = record.fields
                return artist
            } .filter { $0.artistName != "Sans titre" }
            self.artists = artists
            return artists
        
    } catch {
        print("Échec du décodage: \(error)")
        throw error
    }
    
}
}
