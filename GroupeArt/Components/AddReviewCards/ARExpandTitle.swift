//
//  ExpandCardOne.swift
//  GroupeArt
//
//  Created by BlueOneThree on 13/03/2026.
//

import SwiftUI

struct ARExpandTitle: View {
    
    let album: Album
    
    var body: some View {
        VStack {
            Text(album.albumTitle)
                .font(.title2)
                .fontWeight(.bold)
            Text(album.artistName)
                .font(.title3)
            Text(album.yearRelease ?? "")
                .font(.subheadline)
                .fontWeight(.thin)
            HStack {
                Image(systemName: "star.fill")
                    .foregroundStyle(.orangeArt)
                Text(String(format: "%.1f", album.globalReview))
            }
            .padding()
            .frame(width: 378, alignment: .leading)
            
            VStack(alignment: .leading) {
                Text("Description")
                    .fontWeight(.semibold)
                Text("Pas disponible pour le moment.")
            }
            .padding(.leading)
            .frame(width: 378, alignment: .leading)
        }
        .frame(width: 378, height: 260)
        .glassEffect(in: .rect(cornerRadius: 28.0))
//        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        .padding()
    }
}

// Ajout pour ConcertView
struct ARExpandTitleConcert: View {
    let concert: Concert

    var body: some View {
        VStack {
            Text(concert.concertTitle)
                .font(.title2)
                .fontWeight(.bold)
            Text(concert.artistName)
                .font(.title3)
            Text(concert.concertDate ?? "")
                .font(.subheadline)
                .fontWeight(.thin)
            HStack {
                Image(systemName: "star.fill")
                    .foregroundStyle(.orangeArt)
                // La note triche, à modifier plus tards
                Text("4,5")
            }
            .padding()
            .frame(width: 378, alignment: .leading)

            VStack(alignment: .leading) {
                Text("Description")
                    .fontWeight(.semibold)
                Text("Pas disponible pour le moment.")
            }
            .padding(.leading)
            .frame(width: 378, alignment: .leading)
        }
        .frame(width: 378, height: 260)
        .glassEffect(in: .rect(cornerRadius: 28.0))
        .padding()
    }
}

#Preview {
    ARExpandTitle(album: .mock)
}
