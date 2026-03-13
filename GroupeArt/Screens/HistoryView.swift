//
//  HistoryView.swift
//  GroupeArt
//
//  Created by FUVE on 10/03/2026.
//

import SwiftUI

struct HistoryView: View {
    @State private var histoTypeFilter: Int = 0

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
                    LazyVStack(alignment: .leading) {

                        Picker("Filtrer par type", selection: $histoTypeFilter) {
                            HStack {
                                Image(systemName: "music.note")
                                Text("Morceaux")
                            }.tag(0)

                            HStack {
                                Image(systemName: "music.microphone")
                                Text("Artists")
                            }.tag(1)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)

                        switch histoTypeFilter {
                        case 0:
                            HistoTrack()
                        case 1:
                            HistoArtist()
                        default:
                            EmptyView()
                        }
                    }
                }
            }
            .navigationTitle("Historique")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    HistoryView()
}


