//
//  LastFMButton.swift
//  GroupeArt
//
//  Created by FUVE on 12/03/2026.
//

import SwiftUI

struct LastFmButton: View {
    let url: String

    var body: some View {
        Button {
            if let url = URL(string: url) {
                UIApplication.shared.open(url)
            }
        } label: {
            HStack {
                Text("Voir sur Last.fm")
                    .foregroundStyle(.black)
                    .fontWeight(.semibold)
                    .padding()
                Spacer()
                Image("lastfm")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32, height: 32)
            }
            .padding(.horizontal, 16)
            .frame(width: 325, height: 57)
            //EFFET LIQUID GLASS
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(.ultraThinMaterial)
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                }
            )
            .cornerRadius(28)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        }
    }
}

#Preview {
    LastFmButton(url: "https://www.last.fm/music/Daft+Punk/_/One+More+Time")
}
