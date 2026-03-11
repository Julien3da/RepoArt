//
//  AllListView.swift
//  GroupeArt
//
//  Created by Julien Estrada on 10/03/2026.
//

import SwiftUI

struct AllListView: View {
    
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
                    VStack {
                        HStack {
                            ListFavoriteCard(symbol: "menucard", titleFavoriteList: "Albums favoris")
                            ListFavoriteCard(symbol: "music.microphone", titleFavoriteList: "Artistes favoris")
                            ListFavoriteCard(symbol: "music.note.house", titleFavoriteList: "Concert vus")
                        }
                        
                        Divider()
                            .padding(.horizontal)
                        
                        ListCard(
                            title: "Tout mes vinyles",
                            coverList: "listVinyles",
                            imagesAlbum: ["thrillerCover", "abbeyRoadCover", "badCover", "hotelCalCover", "sosCover", "hutCover"]
                        )
                        
                        ListCard(
                            title: "Mes albums pour lover",
                            coverList: "listLove",
                            imagesAlbum: ["utopiaCover", "thrillerCover", "abbeyRoadCover"]
                        )
                        
                        ListCard(
                            title: "Mes albums en cassettes",
                            coverList: "listTape",
                            imagesAlbum: ["utopiaCover", "thrillerCover", "abbeyRoadCover", "badCover", "hotelCalCover", "sosCover"]
                        )
                        
                        ListCard(
                            title: "Love",
                            coverList: "mjPic",
                            imagesAlbum: ["utopiaCover", "thrillerCover", "abbeyRoadCover"]
                        )
                    }
                }
            }
            .navigationTitle("Mes listes")
        }
    }
}

#Preview {
    AllListView()
}
