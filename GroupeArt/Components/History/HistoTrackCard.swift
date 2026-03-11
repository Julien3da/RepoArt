//  GroupeArt
//
//  Created by FUVE on 05/03/2026.
//

import SwiftUI

struct HistoTrackCard: View {
    let track : Track
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(track.trackTitle)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(track.trackArtist.artistName)
                    .fontWeight(.thin)
            }
            .padding(.leading)
            
            Spacer()
            
            Image(track.albumCover)
                .resizable()
                .scaledToFill()
                .frame(width: 55, height: 55)
                .cornerRadius(12)
                .padding(.trailing)
        }
        .frame(width: 360, height: 84)
        //EFFET LIQUID GLASS
        .background(
            ZStack {
                // Le matériau flou (Glassmorphism)
                RoundedRectangle(cornerRadius: 28)
                    .fill(.ultraThinMaterial)
                
                // fine bordure brillante pour accentuer l'effet "verre"
                RoundedRectangle(cornerRadius: 28)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            }
        )
        .background(Color.grisArt.opacity(0.75))
        .cornerRadius(28)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    HistoTrackCard(track: mockTracks[1])
}
