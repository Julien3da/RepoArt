//
//  AppleMusicButtons.swift
//  GroupeArt
//
//  Created by BlueOneThree on 11/03/2026.
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
        .glassEffect(in: .rect(cornerRadius: 28.0))
    }
}

#Preview {
    AppleMusicButton()
}
