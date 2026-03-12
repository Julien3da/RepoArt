//
//  HistoTrack.swift
//  GroupeArt
//
//  Created by FUVE on 06/03/2026.
//

import SwiftUI

struct HistoTrack: View {
    
    var body: some View {
        NavigationStack {
                
                
                    VStack(spacing: 16) {
                        ForEach(mockTracks) { track in
                            NavigationLink {
                                TrackDetails(track: track)
                            } label: {
                                HistoTrackCard(track: track)
                            } .buttonStyle(.plain)
                        }
                    }
                    .padding()
                
        }
    }
}

#Preview {
    HistoTrack()
}

