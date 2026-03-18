//  Created by BlueOneThree on 10/03/2026.
//

import SwiftUI

struct HistoTrack: View {
    @State private var viewModel = LastFmViewModel()

    

    var body: some View {
        VStack{
            ForEach(viewModel.tracks) { track in
                NavigationLink {
                    TrackDetails(track: track)
                } label: {
                    HistoTrackCard(track: track)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .task {
            await viewModel.getRecentTracks()
        }
    }
}

#Preview {
    HistoTrack()
}

