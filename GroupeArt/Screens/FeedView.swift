
//
//  FeedView.swift
//  GroupeArt
//
//  Created by Julien Estrada on 04/03/2026.
//

import SwiftUI

struct FeedView: View {
    
    @State private var feedFollowFilter = 0
    @State private var feedTypeFilter = 0
    
    var body: some View {
        
        NavigationStack {
                            
                ZStack{
                  
                    
                    VStack(alignment: .leading){
                        
                    }
                    
                    ScrollView(showsIndicators: false){
                        
                        VStack(alignment: .leading){
                            Picker("Filtrer par suivi", selection: $feedFollowFilter) {
                                Text("Tout").tag(0)
                                Text("Suivis").tag(1)
                            }
                            .pickerStyle(.segmented)
                            
                            Picker("Filtrer par type", selection: $feedTypeFilter) {
                                
                                HStack{
                                    Image(systemName: "square.stack")
                                    Text("Albums")
                                } .tag(0)
                                
                                HStack{
                                    Image(systemName: "music.note.house.fill")
                                    Text("Concerts")
                                } .tag(1)
                                
                                HStack{
                                    Image(systemName: "music.note")
                                    Text("Morceaux")
                                } .tag(2)
                                
                            } .accentColor(.orange)
                            
                            FeedCardView()
                            FeedCardView()
                            FeedCardView()
                            FeedCardView()
                            FeedCardView()
                            FeedCardView()
                            
                        } .padding()
                        
                    }
                    
                }
                .navigationTitle("Feed")
        }
    }
}
#Preview {
    FeedView()
}
