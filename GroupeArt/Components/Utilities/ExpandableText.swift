//
//  ExpandableText.swift
//  GroupeArt
//
//  Created by BlueOneThree on 11/03/2026.
//

import SwiftUI

struct ExpandableText: View {
    let text: String
    @State private var expanded: Bool = false
    private let lineLimit: Int = 2
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Biographie")
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
        .glassEffect(in: .rect(cornerRadius: 28.0))
        .onTapGesture {
            expanded.toggle()
        }
        .animation(.easeInOut(duration: 0.25), value: expanded)
    }
}
#Preview {
    ExpandableText(text: "Chanteuse américaine de R&B alternatif reconnue pour ses textes introspectifs et sa voix unique.")
        .padding()
}

