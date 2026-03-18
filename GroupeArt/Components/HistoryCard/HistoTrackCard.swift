//
//  HistoAlbumCard.swift
//  GroupeArt
//
//  Created by BlueOneThree on 11/03/2026.
//

import SwiftUI

struct HistoTrackCard: View {
    let track: LastFmTrack

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(track.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(track.artist.text)
                    .fontWeight(.thin)
            }
            .padding(.leading)
            
            Spacer()
            
            AsyncImage(url: track.coverURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 55, height: 55)
                        .cornerRadius(14)
                        .padding(.horizontal)
                case .failure(_):
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.gray)
                        .frame(width: 144, height: 144)
                default:
                    ProgressView()
                        .frame(width: 144, height: 144)
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 84)
        .glassEffect(in: .rect(cornerRadius: 28.0))
//        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}
#Preview {
    HistoTrackCard(track: LastFmTrack(
        name: "ALL MINE",
        url: "https://last.fm",
        artist: LastFmArtist(text: "Brent Faiyaz"),
        album: LastFmAlbum(text: "WASTELAND"),
        image: [LastFmImage(text: "https://lastfm.freetls.fastly.net/i/u/770x0/c1da41881fe673f8a02693ff07c455e9.jpg#c1da41881fe673f8a02693ff07c455e9", size: "extralarge")]
    ))
    .padding()
}
