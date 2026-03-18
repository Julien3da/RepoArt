//
//  LastFMButton.swift
//  GroupeArt
//
//  Created by BlueOneThree on 12/03/2026.
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
                    .foregroundStyle(.noirArt)
                    .fontWeight(.semibold)
                    .padding()
                Spacer()
                Image("lastfm")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32, height: 32)
            }
        }
        .padding(.horizontal, 16)
        .frame(width: 325, height: 57)
        .glassEffect(in: .rect(cornerRadius: 28.0))
    }
}

#Preview {
    LastFmButton(url: "https://www.last.fm/music/Daft+Punk/_/One+More+Time")
}
