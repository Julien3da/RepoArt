//
//  FakeFeedCardView4.swift
//  GroupeArt
//
//  Created by apprenant92 on 19/03/2026.
//

import SwiftUI

struct FakeFeedCardView4: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.grisArt)
                .glassEffect(.regular.tint(Color.grisArt), in: RoundedRectangle(cornerRadius: 24))
                .frame(height: 220)
                .frame(maxWidth: .infinity)
                .shadow(color: .black.opacity(0.12), radius: 10, x: 0, y: 4)
                .padding(.vertical, 3)
            
            VStack(alignment: .leading) {
                
                HStack(alignment: .top) {
                    
                    VStack(alignment: .leading) {
                        
                        
                            Text("Hurry Hup Toumorrow")
                                .font(.title3)
                                .bold()

                            Text("The Weeknd")
                                .font(.subheadline)
                                .padding(.bottom, 10)


                        
                        Text("Wowww")
                            .frame(width: 230, alignment: .leading)
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.bottom, 4)
                            .lineLimit(3)
                        
                                                
                        Text("Trop wowwww")
                            .frame(width: 230, alignment: .leading)
                            .font(.caption)
                            .padding(.bottom, 4)
                            .lineLimit(3)
                        
                        HStack (spacing: 2) {
                            
                            Image(systemName: "star.fill")
                                .font(.subheadline)
                                .padding(.bottom, 4)
                                .foregroundStyle(Color.orange)
                            
                            Text("5/5")
                                .font(.subheadline)
                                .padding(.bottom, 4)
                        }
                        
                        Text("de leasounds42")
                            .font(.caption)
                            .bold()
                        
                        
                    }
                    .padding(.leading)
                    
                    VStack {
                        
                        HStack {
                            Spacer()
                            
                            Image(.hutCover)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.trailing, 18)

                            
                        }
                        
//                        HStack {
//                            Spacer()
//                            Button {
//                            } label: {
//                                Image(systemName: "chevron.right")
//                                    .frame(width: 12, height: 12)
//                                    .foregroundStyle(Color.black)
//                                    .font(.system(size: 12))
//                                    .bold()
//                                    .padding(12)
//                            }
//                            .glassEffect()
//                            .padding(.trailing, 14)
//                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    FakeFeedCardView4()
}
