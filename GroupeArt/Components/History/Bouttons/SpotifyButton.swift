//
//  SpotifyButton.swift
//  GroupeArt
//
//  Created by FUVE on 10/03/2026.
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
#Preview {
    SpotifyButton()
}
