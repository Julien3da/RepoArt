//
//  HistoTrack.swift
//  GroupeArt
//
//  Created by FUVE on 11/03/2026.
//

import SwiftUI

struct HistoTrack: View {
//<<<<<<< HEAD:GroupeArt/Screens/History/HistoTrack.swift
    
    @State var viewModel = TrackViewModel()

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
                    VStack(spacing: 16) {
                        ForEach(viewModel.tracks) { track in
                            HistoTrackCard(track: track)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Historique") // à enlever de la scroll
        }
        .task {
            try? await viewModel.fetchTracks()
        }
//=======
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//>>>>>>> main:GroupeArt/Screens/HistoryScreen/HistoryCategory/HistoTrack.swift
    }
}

#Preview {
    HistoTrack()
}
