
//
//  FeedView.swift
//  GroupeArt
//
//  Created by Julien Estrada on 04/03/2026.
//

import SwiftUI

struct FeedView: View {
    
    @State private var artistVM = ArtistViewModel()
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
                        
//                        Picker("Filtrer par suivi", selection: $feedFollowFilter) {
//                            Text("Tout").tag(0)
//                            Text("Suivis").tag(1)
//                        }
//                        .pickerStyle(.segmented)
                        
                        Picker("Filtrer par type", selection: $feedTypeFilter) {
                            
                            HStack{
                                Image(systemName: "play.circle")
                                Text("Tout")
                            } .tag(0)
                            
                            HStack{
                                Image(systemName: "square.stack")
                                Text("Albums")
                            } .tag(1)
                            
                            HStack{
                                Image(systemName: "music.note")
                                Text("Morceaux")
                            } .tag(2)
                            
//                            HStack{
//                                Image(systemName: "music.note.house.fill")
//                                Text("Concerts")
//                            } .tag(3)
                            
                        } .accentColor(.orange)
                            .accentColor(.orange)
                            
                            
                        
                        if viewModel.isLoading {
                            ProgressView("Chargement du feed...")
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                                let filteredReviews = viewModel.reviews.filter { review in
                                    switch feedTypeFilter {
                                        case 1: // Albums
                                            return (review.album?.isEmpty == false)
                                            
                                        case 2: // Tracks
                                            return (review.track?.isEmpty == false)
                                            
                                        default:
                                            return true
                                        }
                            }
                            
                            FakeFeedCardView1()
                            FakeFeedCardView2()
                            FakeFeedCardView3()
                            FakeFeedCardView4()
                            
                            LazyVStack {
                                ForEach(filteredReviews) { review in
                                    FeedItemView(
                                        review: review,
                                        albums: albumVM.albums,
                                        tracks: trackVM.tracks,
                                        artists: artistVM.artists
                                    )
                                }
                            }
                            
                        }
                    } .padding()
                }
            } .navigationTitle("Feed")
        }
        .task {


            do {
                _ = try await viewModel.fetchReviews()
                _ = try await albumVM.fetchAlbums()
                _ = try await trackVM.fetchTracks()
                _ = try? await artistVM.fetchArtists()
            } catch {
                print("Erreur chargement feed : \(error)")
            }
        }
    }
}


#Preview {
    FeedView()
}
