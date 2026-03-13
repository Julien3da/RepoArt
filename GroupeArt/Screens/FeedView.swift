
//
//  FeedView.swift
//  GroupeArt
//
//  Created by Julien Estrada on 04/03/2026.
//

import SwiftUI

struct FeedView: View {
    
    @State private var viewModel = ReviewViewModel()
    @State private var albumVM = AlbumViewModel()
    @State private var trackVM = TrackViewModel()
    
    @State private var feedFollowFilter = 0
    @State private var feedTypeFilter = 0
    
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
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        
                        Picker("Filtrer par suivi", selection: $feedFollowFilter) {
                            Text("Tout").tag(0)
                            Text("Suivis").tag(1)
                        }
                        .pickerStyle(.segmented)
                        
                        Picker("Filtrer par type", selection: $feedTypeFilter) {
                            
                            HStack{
                                Image(systemName: "square.stack")
                                Text("Albums")
                            } .tag(0)
                            
                            HStack{
                                Image(systemName: "music.note.house.fill")
                                Text("Concerts")
                            } .tag(1)
                            
                            HStack{
                                Image(systemName: "music.note")
                                Text("Morceaux")
                            } .tag(2)
                            
                        } .accentColor(.orange)
                            .accentColor(.orange)
                        
                        if viewModel.isLoading {
                            ProgressView("Chargement du feed...")
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            
                            
                            ForEach(viewModel.reviews) { review in
                                
                                let album = albumVM.albums.first { album in
                                    review.album?.contains(album.id.uuidString) ?? false
                                }
                                
                                let track = trackVM.tracks.first { track in
                                    review.track?.contains(track.id.uuidString) ?? false
                                }
                                
                                FeedCardView(
                                    review: review,
                                    album: album,
                                    track: track
                                )
                            }
 
                        }
                    } .padding()
                }
            } .navigationTitle("Feed")
        }
        .task {
            do {
                try await viewModel.fetchReviews()
                try? await albumVM.fetchAlbums()
                try? await trackVM.fetchTracks()
            } catch {
                print("Erreur chargement feed : \(error)")
            }
        }
    }
}


#Preview {
    FeedView()
}
