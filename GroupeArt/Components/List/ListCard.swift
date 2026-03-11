//
//  ListCard.swift
//  GroupeArt
//
//  Created by Julien Estrada on 10/03/2026.
//

import SwiftUI

struct ListCard: View {
    var title: String
    var coverList: String
    var imagesAlbum: [String]
    
    var body: some View {
        
        VStack(alignment: .leading){
            Text(title)
                .fontWeight(.semibold)
                .font(.system(size: 23))
            
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color("grisArt"))
                        .glassEffect(.regular.tint(Color("grisArt")), in: RoundedRectangle(cornerRadius: 28))
                        .frame(width: 360, height: 134)
                    
                    HStack(spacing: 12) {
                        Image(coverList)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 110, height: 110)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.4), radius: 8, x: 4, y: 4)
                            .padding(.leading, 17)
                        
                        Rectangle()
                            .fill(Color.noirArt.opacity(0.5))
                            .frame(width: 1, height: 80)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(imagesAlbum, id: \.self) { imageName in
                                    Image(imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 72, height: 72)
                                        .cornerRadius(14)
                                        .opacity(0.85)
                                }
                            }
                            .padding(.trailing, 17)
                        }
                    }
                    .frame(width: 360, height: 134)
                    .clipShape(RoundedRectangle(cornerRadius: 28))
                    
                }
                
            }
        }
    }


#Preview {
    ListCard(
        title: "Mes vinyles",
        coverList: "sosCover",
        imagesAlbum: ["utopiaCover", "hutCover", "badCover", "abbeyRoadCover"]
    )
    .padding()
}
