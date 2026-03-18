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
                            NavigationLink(destination: AlbumFavoriteDetailView()) {
                                ListFavoriteCard(symbol: "menucard", titleFavoriteList: "Albums favoris")
                            }
                            .buttonStyle(.plain)
                            
                            NavigationLink(destination: ArtistFavoriteDetailView()) {
                                ListFavoriteCard(symbol: "music.microphone", titleFavoriteList: "Artistes favoris")
                            }
                            .buttonStyle(.plain)
                            
                            NavigationLink(destination: ConcertFavoriteDetailView()) {
                                ListFavoriteCard(symbol: "music.note.house", titleFavoriteList: "Concert vus")
                            }
                            .buttonStyle(.plain)
                        }
                        
                        
                        
                        Divider()
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            
                            ZStack(alignment: .center) {
                                
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color.orangeArt)
                                    .frame(width: 300, height: 40)
                                    .glassEffect(.regular.tint(Color.orangeArt), in: RoundedRectangle(cornerRadius: 24))
                                    .shadow(radius: 10)
                                
                                Text("Créer une nouvelle liste")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.noirArt)
                            }
                                
                        }

                        
                        ListCard(
                            title: "Mes vinyles",
                            coverList: "listVinyles",
                            imagesAlbum: ["thrillerCover", "abbeyRoadCover", "badCover", "hotelCalCover", "sosCover", "hutCover"]
                        )
                        
                        ListCard(
                            title: "Albums chill",
                            coverList: "listLove",
                            imagesAlbum: ["utopiaCover", "thrillerCover", "abbeyRoadCover"]
                        )
                        
                        ListCard(
                            title: "Pour blindtest",
                            coverList: "listTape",
                            imagesAlbum: ["utopiaCover", "thrillerCover", "abbeyRoadCover", "badCover", "hotelCalCover", "sosCover"]
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
