//
//  AppleMusicButtons.swift
//  GroupeArt
//
//  Created by FUVE on 11/03/2026.
//

import SwiftUI

struct AppleMusicButton: View {
    var body: some View {
        HStack {
            Text("Écoutez sur Apple Music")
                .fontWeight(.semibold)
                .padding()
            Spacer()
            Image("applemusic")
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

#Preview {
    AppleMusicButton()
}
