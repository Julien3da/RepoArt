//
//  AllListView.swift
//  GroupeArt
//
//  Created by Julien Estrada on 10/03/2026.
//

import SwiftUI
import PhotosUI

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
    
    // État pour afficher le modal de création
    @State private var showingNewListModal: Bool = false
    
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
                            // Ouvre le modal de création (sheet)
                            showingNewListModal = true
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
                        .sheet(isPresented: $showingNewListModal) {
                            NewListModalView(isPresented: $showingNewListModal)
                        }
                        .buttonStyle(.plain)

                        
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

// Modal view pour créer une nouvelle liste
struct NewListModalView: View {
    @Binding var isPresented: Bool

    @State private var listName: String = ""
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil

    var body: some View {
        VStack(spacing: 18) {
            // Titre
            Text("Créer une nouvelle liste")
                .font(.system(size: 24, weight: .semibold))
                .padding(.top, 12)

            Spacer().frame(height: 8)

            // Image picker placeholder
            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                ZStack {
                    if let data = selectedImageData, let ui = UIImage(data: data) {
                        Image(uiImage: ui)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 220, height: 220)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.orangeArt, lineWidth: 2))
                    } else {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.white.opacity(0.95))
                            .frame(width: 220, height: 220)
                            .overlay(
                                Image(systemName: "camera")
                                    .font(.system(size: 44))
                                    .foregroundColor(Color.orangeArt)
                            )
                            .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.orangeArt, lineWidth: 2))
                    }
                }
            }
            .onChange(of: selectedItem) { _ , newItem in
                Task {
                    if let item = newItem {
                        if let data = try? await item.loadTransferable(type: Data.self) {
                            await MainActor.run {
                                selectedImageData = data
                            }
                        }
                    }
                }
            }

            // Nom de la liste editable
            VStack(spacing: 6) {
                Text("Nom de la liste")
                    .font(.system(size: 18, weight: .bold))

                TextField("Entrez un nom", text: $listName)
                    .font(.system(size: 16))
                    .padding(12)
                    .background(Color.white.opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 24)
            }
            .padding(.top, 8)

            Spacer()

            // Bouton bas — volontairement inactif (désactivé)
            Button(action: {
                // Intentionnellement vide — bouton inactif
            }) {
                Text("Créer la liste")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.noirArt)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color.orangeArt)
                    .clipShape(Capsule())
                    .shadow(radius: 6)
                    .padding(.horizontal, 24)
            }
            .disabled(true)
            .padding(.bottom, 20)
        }
        .presentationDetents([.fraction(0.9)])
        .onTapGesture {
            // Ne pas fermer lors du tap interne
        }
        .background(
            // Fond blanc arrondi pour la sheet
            Color(UIColor.systemBackground)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

#Preview {
    AllListView()
}
