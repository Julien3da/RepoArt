//
//  HistoTrack.swift
//  GroupeArt
//
//  Created by FUVE on 06/03/2026.
//

import SwiftUI

struct HistoTrack: View {

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
                        ForEach(mockTracks) { track in
                            HistoTrackCard(track: track)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Historique") // à enlever de la scroll
        }
    }
}

#Preview {
    HistoTrack()
}
