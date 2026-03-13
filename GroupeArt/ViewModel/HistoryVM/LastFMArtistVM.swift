//
//  LastFMArtistVM.swift
//  GroupeArt
//
//  Created by FUVE on 12/03/2026.
//

import Foundation

@Observable class LastFmArtistViewModel {
    var artists: [LastFmArtistInfo] = []

    let apiKey = "b33272179afb91efb4c7598685f59101"
    let username = "BlueOneThree"

    func getRecentArtists() async {
        let urlString = "https://ws.audioscrobbler.com/2.0/?method=user.gettopartists&user=\(username)&api_key=\(apiKey)&format=json&limit=20"
        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(LastFmTopArtistsResponse.self, from: data)
            var artists = decoded.topartists.artist

            // Charger les infos Wikipedia pour chaque artiste
            for i in artists.indices {
                let (imageURL, bio) = await getArtistWikipediaInfo(name: artists[i].name)
                artists[i].wikipediaImageURL = imageURL
                artists[i].wikipediaBio = bio
            }

            self.artists = artists
            print("✅ \(self.artists.count) artistes récupérés")
        } catch {
            print("❌ Erreur : \(error)")
        }
    }

    func getArtistWikipediaInfo(name: String) async -> (URL?, String?) {
        let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? name
        let urlString = "https://en.wikipedia.org/api/rest_v1/page/summary/\(encodedName)"
        guard let url = URL(string: urlString) else { return (nil, nil) }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(WikipediaResponse.self, from: data)
            let imageURL = decoded.thumbnail?.source.flatMap { URL(string: $0) }
            return (imageURL, decoded.extract)
        } catch {
            return (nil, nil)
        }
    }
}
