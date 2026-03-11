//
//  ExpandableGlassText.swift
//  GroupeArt
//
//  Created by FUVE on 10/03/2026.
//

import SwiftUI

struct ExpandableArtistDescription: View {
    let text: String
    @State private var expanded: Bool = false
    private let lineLimit: Int = 2
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Biography")
                .fontWeight(.semibold)
                
            Text(text)
                .lineLimit(expanded ? .max : lineLimit)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .animation(.easeInOut(duration: 0.25), value: expanded)
            
            if !expanded {
                Text("Voir plus")
                    .font(.caption)
                    .foregroundColor(.orangeArt)
            }
        }
        .padding()
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 28)
                    .fill(.ultraThinMaterial)
                
                RoundedRectangle(cornerRadius: 28)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            }
        )
        .background(Color.grisArt.opacity(0.1))
        .cornerRadius(28)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        .onTapGesture {
            expanded.toggle()
        }
        .animation(.easeInOut(duration: 0.25), value: expanded)
    }
}
#Preview {
    ExpandableArtistDescription(text: "Chanteuse américaine de R&B alternatif reconnue pour ses textes introspectifs et sa voix unique.")
        .padding()
}
