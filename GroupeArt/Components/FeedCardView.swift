//
//  FeedCardView.swift
//  GroupeArt
//
//  Created by apprenant92 on 10/03/2026.
//

import SwiftUI

struct FeedCardView: View {
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 24)
                .fill(.ultraThinMaterial)
                .glassEffect(Glass.clear, in: .rect(cornerRadius: 24))
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .shadow(radius: 4, x: 0, y: 4)
                .padding(.vertical, 3)
            
            VStack(alignment: .leading){
                
                HStack (alignment: .top){
                    
                    VStack(alignment: .leading){
                        Text("Rome")
                            .font(.title)
                            .bold()
                        Text("Solann")
                            .font(.title2)
                            .padding(.bottom, 4)
                        
                        Text("Ceci est un paragraphe de commentaire nanani nanana j'adore écrire.")
                            .frame(width: 230)
                            .font(.caption)
                            .padding(.bottom, 4)
                        
                        Text("De Nom Utilisateur")
                            .font(.caption)
                            .bold()
                        

                    } .padding(.leading)
                    
                    VStack{
                        
                        HStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 100, height: 100)
                                .foregroundStyle(Color.gray)
                                .padding(14)
                            
                        }
                        
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "chevron.right")
                                    .frame(width: 12, height: 12)
                                    .foregroundStyle(Color.black)
                                    .font(.system(size: 12))
                                    .bold()
                                    .padding(12)
                                    
                                    
                            }.glassEffect()
                                .padding(.trailing, 14)
                            
                        }
                        
                        
                        
                        
                    }
                    
                    Spacer()
                    
                    
                }
                
                
            }
        }
    }
}

#Preview {
    FeedCardView()
}
