//
//  LastFMVM.swift
//  GroupeArt
//
//  Created by BlueOneThree on 12/03/2026.
//

import Foundation

@Observable class LastFmViewModel {
    var tracks: [LastFmTrack] = []

    let apiKey = "b33272179afb91efb4c7598685f59101"
    let username = "BlueOneThree"

    func getRecentTracks() async {
        let urlString = "https://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=\(username)&api_key=\(apiKey)&format=json&limit=20"
        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let raw = String(data: data, encoding: .utf8) ?? ""
            print("Last.fm : \(raw)")
            let decoded = try JSONDecoder().decode(LastFmResponse.self, from: data)
            self.tracks = decoded.recenttracks.track
            print("\(self.tracks.count) tracks récupérés")
        } catch {
            print("Erreur : \(error)")
        }
    }
}
