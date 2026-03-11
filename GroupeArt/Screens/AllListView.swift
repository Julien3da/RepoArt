//
//  AllListlView.swift
//  GroupeArt
//
//  Created by Julien Estrada on 10/03/2026.
//

import SwiftUI

struct AllListlView: View {
    
    let backgroundGradient = LinearGradient(
        stops: [
            Gradient.Stop(color: .grisArt, location: 0.07),
            Gradient.Stop(color: .beigeArt, location: 0.66),
            Gradient.Stop(color: .orangeArt, location: 1.0)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    var body: some View {
        
        
        NavigationStack {
            ZStack {
                backgroundGradient.ignoresSafeArea()
                
                ScrollView {
                    VStack  {
                        HStack  {
                            
                            ListFavoriteCard(symbol: "menucard", titleFavoriteList: "Albums favoris")
                            ListFavoriteCard(symbol: "music.microphone", titleFavoriteList: "Artistes favoris")
                            ListFavoriteCard(symbol: "music.note.house", titleFavoriteList: "Concert vus")
                            
                        }
                        Spacer()
                        
                        ListCard(title: "Vinyles", images: ["utopiaCover", "thrillerCover", "abbeyRoadCover", "badCover", "hotelCalCover", "sosCover", "hutCover"])
                        
                        
                        ListCard(title: "Love", images: ["utopiaCover", "thrillerCover", "abbeyRoadCover"])
                        
                        ListCard(title: "Vinyles", images: ["utopiaCover", "thrillerCover", "abbeyRoadCover", "badCover", "hotelCalCover", "sosCover", "hutCover"])
                        
                        ListCard(title: "Love", images: ["utopiaCover", "thrillerCover", "abbeyRoadCover"])
                        
                    }
                }
            }
            .navigationTitle(Text("Listes"))
        }
    }
}

#Preview {
    AllListlView()
}
