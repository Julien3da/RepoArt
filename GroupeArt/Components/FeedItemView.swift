//
//  FeedItemView.swift
//  GroupeArt
//
//  Created by apprenant92 on 17/03/2026.
//

import SwiftUI

struct FeedItemView: View {
    let review: Review
    let albums: [Album]
    let tracks: [Track]
    let artists: [Artist]

    var body: some View {

        let album = albums.first {
            review.album?.contains($0.id) == true
        }

        let track = tracks.first {
            review.track?.contains($0.id) ?? false
        }

        let artist = artists.first {
            track?.trackArtist?.contains($0.id) ?? false
        }

        FeedCardView(
            review: review,
            album: album,
            track: track,
            artist: artist
        )
    }
}

