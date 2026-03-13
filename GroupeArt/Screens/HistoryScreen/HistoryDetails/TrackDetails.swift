//
//  AlbumDetails.swift
//  GroupeArt
//
//  Created by FUVE on 10/03/2026.
//

import SwiftUI

struct TrackDetails: View {
    let track: LastFmTrack

    var body: some View {
        ZStack {
            AsyncImage(url: track.coverURL) { phase in
                if case .success(let image) = phase {
                    image
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .blur(radius: 30)
                }
            }

            VStack {
                VStack {
                    AsyncImage(url: track.coverURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 300)
                                .cornerRadius(18)
                        default:
                            RoundedRectangle(cornerRadius: 18)
                                .fill(Color.gray)
                                .frame(width: 300, height: 300)
                        }
                    }

                    Text(track.album.text.isEmpty ? "Album inconnu" : track.album.text)
                        .font(.title)
                        .fontWeight(.bold)

                    Text(track.artist.text)
                        .font(.title2)
                }
                .frame(width: 325, height: 403)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 28)
                            .fill(.ultraThinMaterial)
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    }
                )
                .background(Color.grisArt.opacity(0.1))
                .cornerRadius(28)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                .padding()

                LastFmButton(url: track.url)
                    .padding()
            }
        }
    }
}

#Preview {
    TrackDetails(track: LastFmTrack(
        name: "ALL MINE",
        url: "https://last.fm",
        artist: LastFmArtist(text: "Brent Faiyaz"),
        album: LastFmAlbum(text: "WASTELAND"),
        image: [LastFmImage(text: "https://lastfm.freetls.fastly.net/i/u/770x0/c1da41881fe673f8a02693ff07c455e9.jpg#c1da41881fe673f8a02693ff07c455e9", size: "extralarge")]
    ))
}
