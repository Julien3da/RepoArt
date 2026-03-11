//
//  ListFavoriteCard.swift
//  GroupeArt
//
//  Created by Julien Estrada on 10/03/2026.
//

import SwiftUI

struct ListFavoriteCard: View {
    
    var symbol: String
    var titleFavoriteList: String
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.grisArt)
                    .glassEffect(.regular.tint(Color.grisArt), in: RoundedRectangle(cornerRadius: 24))
                    .frame(width: 110, height: 110)
                    .shadow(color: .black.opacity(0.12), radius: 10, x: 0, y: 4)
                
                Image(systemName: symbol)
                    .font(.system(size: 36, weight: .regular))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.orangeArt, .orangeArt.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            
            Text(titleFavoriteList)
                .font(.system(size: 13, weight: .semibold))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: 110)
        }
    }
}

#Preview {
    HStack(spacing: 16) {
        ListFavoriteCard(symbol: "menucard", titleFavoriteList: "Albums favoris")
    }
    .padding()
}
