//
//  SpotifyButton.swift
//  GroupeArt
//
//  Created by BlueOneThree on 11/03/2026.
//

import SwiftUI

struct SpotifyButton: View {
    var body: some View {
        HStack {
            Text("Écoutez sur Spotify")
                .fontWeight(.semibold)
                .padding()
            Spacer()
            Image("spotify")
                .resizable()
                .scaledToFill()
                .frame(width: 32, height: 32)
        }
        .padding(.horizontal, 16)
        .frame(width: 325, height: 57)
        .glassEffect(in: .rect(cornerRadius: 28.0))
    }
}
#Preview {
    SpotifyButton()
}
