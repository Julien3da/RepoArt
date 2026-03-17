//
//  ARCard.swift
//  GroupeArt
//
//  Created by BlueOneThree on 13/03/2026.
//
//

// mock pour la preview

import SwiftUI

extension Album {
    static let mock = Album(
        albumTitle: "Abbey Road",
        yearRelease: "1969",
        artistNameFromArtist: ["The Beatles"],
        albumCover: [AirtableAttachment(
            url:"https://upload.wikimedia.org/wikipedia/commons/a/a4/The_Beatles_Abbey_Road_album_cover.jpg",
            filename: "cover.png",
            thumbnails: nil
        )]
    )
}

