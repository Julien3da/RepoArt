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
                
                VStack(alignment: .leading) {
                    Picker("Filtrer par type", selection: $histoTypeFilter) {
                        HStack {
                            Image(systemName: "square.stack")
                            Text("Albums")
                        }.tag(0)
                        
                        HStack {
                            Image(systemName: "music.microphone")
                            Text("Artists")
                        }.tag(1)
                        
                        HStack {
                            Image(systemName: "music.note")
                            Text("Morceaux")
                        }.tag(2)
                    }
                    
                    .padding(.horizontal)
                    
                    // Affichage de la vue selon le type sélectionné
                    Group {
                        switch histoTypeFilter {
                        case 0:
                            HistoAlbum()
                        case 1:
                            HistoArtist()
                        case 2:
                            HistoTrack()
                        default:
                            EmptyView()
                        }
                    }
                }
                .navigationTitle("Historique")
            }
        }
    }
}
#Preview {
    HistoryView()
}
