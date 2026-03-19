//
//  ProfilUserView.swift
//  GroupeArt
//
//  Created by apprenant84 on 12/03/2026.
//

import SwiftUI

struct ProfilUserView: View {
    let user: User
    @State private var userVM = UserViewModel()
    @State private var showSheet = true
    @State private var feedTypeFilter = 0
    
    struct RoundedCorner: Shape {
        var radius: CGFloat = 30
        var corners: UIRectCorner = [.topLeft, .topRight]

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            return Path(path.cgPath)
        }
    }

    
    struct SmallActionButtonView: View {
        let title: String
        let backgroundColor: Color
        let textColor: Color
        let action: () -> Void

        var body: some View {
            Button(action: action) {
                Text(title)
                    .font(.body)
                    .foregroundColor(textColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
                    .background(backgroundColor)
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 4)
            }
        }
    }
    
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
                
                VStack(spacing: 0){
                    HStack{
                        Spacer()
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.orange)
                            .padding(.trailing, 24)
                            .padding(.top)
                            .font(.system(size: 24))

                    }
                    .padding(.top, 32)
                    
                    HStack (alignment: .top, spacing: 16){
                       
                        if let urlString = user.userPic?.first?.url, let url = URL(string: urlString)  {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 112, height: 112)
                                    .cornerRadius(14)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14)
                                            .stroke(.orange, lineWidth: 3)
                                    )
                                
                            } placeholder: {
                                Color.gray.opacity(0.3)
                                    .overlay(ProgressView())
                            }
                        } else {
                            RoundedRectangle(cornerRadius: 80)
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 320)
                                .overlay(
                                    Image(systemName: "music.note")
                                        .font(.system(size: 60))
                                        .foregroundColor(.gray)
                                )
                        }
                        VStack(alignment: .leading){
                            
                            HStack{
                                Text("Julien Serdaigle")
                                    .font(.system(size: 20, weight: .semibold))
                                Image(systemName: "checkmark.seal")
                                    .foregroundColor(.orange)
                                
                                
                            }
                            Label("Marseille", systemImage: "location.fill")
                                .foregroundColor(.orange)
                            
                            Spacer()
                            
                            HStack(spacing: 30) {
                                VStack{
                                    Text("36k")
                                        .font(.system(size: 16, weight: .semibold))
                                    Text("followers")
                                }
                                VStack{
                                    Text("46")
                                        .font(.system(size: 16, weight: .semibold))
                                    Text("following")
                                }
                                VStack{
                                    Text("56")
                                        .font(.system(size: 16, weight: .semibold))
                                    Text("Avis")
                                }
                            }
                        }
                        .frame(maxHeight: .infinity)
                    }
                    .frame(height: 112)
                    
                    VStack(alignment: .leading){
                        Text("Lorem ipsum. Etiam ac leo a risus tristique")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding(.leading)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 32)
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
                    .background(Color.grisArt.opacity(0.1))
                    .cornerRadius(28)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    
               
                    
                    HStack{
                        SmallActionButtonView(
                            title: "Modifier le profil",
                            backgroundColor: Color.orange.opacity(0.8),
                            textColor: .black,) {}
                        SmallActionButtonView(
                            title: "Partager le profil",
                            backgroundColor: Color.black.opacity(0.8),
                            textColor: .white) {}
                    }.padding(16)
                    
                    
                    VStack(alignment: .leading) {
                        Picker("Filtrer par type", selection: $feedTypeFilter) {
//                            Label("Avis", systemImage: "chevron.up.chevron.down")
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                                .padding(.leading, 20)
//                                .font(.headline)
//                                .fontWeight(.semibold)
//                                .foregroundColor(.orange)
//                                .padding(.top, 8)
//                                .padding(.bottom, -4)
                            
                            HStack{
                                Text("Avis")
                            } .tag(0)
                            HStack{
                                Text("Historique")
                            } .tag(1)
                            HStack{
                                Text("Listes")
                            } .tag(2)

                        }
                        .accentColor(.orange)
                        .padding(.leading, 20)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .offset(y: 4)

                        ScrollView {
                            VStack(alignment: .leading, spacing: 16) {
                                ForEach(0..<10) { _ in
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.white)
                                        .frame(height: 120)
                                        .shadow(radius: 4)
                                }
                            }
                            .padding()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .background(
                        ZStack {
                            // Ombre (derrière)
                            RoundedCorner(radius: 30, corners: [.topLeft, .topRight])
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: -6)
                            backgroundGradient.ignoresSafeArea()
                                .clipShape(
                                    RoundedCorner(radius: 30, corners: [.topLeft, .topRight])
                                )
                        }
                    )
                }
                .ignoresSafeArea()
            }
        }
        .task {
            do {
                _ = try await userVM.fetchUsers()
            } catch {
                print("Erreur chargement: \(error)")
            }
        }
        
    }
}

#Preview {
    ProfilUserView(user: .mock)
}
