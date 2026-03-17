//
//  EditProfileV.swift
//  GroupeArt
//
//  Created by FUVE on 17/03/2026.
//

import SwiftUI
import PhotosUI

struct EditProfileV: View {
    
    @State var user: User
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    
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
        ZStack {
            backgroundGradient.ignoresSafeArea()
            ScrollView(showsIndicators : false) {
            VStack(spacing: 20) {
                
                // PHOTO
                ZStack {
                    if let data = selectedImageData,
                       let uiImage = UIImage(data: data) {
                        
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                        
                    } else if let urlString = user.userPic?.first?.imageURL,
                              let url = URL(string: urlString) {
                        
                        AsyncImage(url: url) { image in
                            image.resizable().scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                    } else {
                        ZStack {
                            Rectangle()
                                .fill(Color.beigeArt.opacity(0.3))
                            Image(systemName: "person.fill")
                                .font(.system(size: 80))
                                .foregroundStyle(.orangeArt)
                        }
                    }
                }
                .frame(width: 168, height: 168)
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.orangeArt, lineWidth: 2)
                )
                
                // bouton changer photo
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Text("Modifier la photo")
                        .font(.subheadline)
                }
                
                // USERNAME
                VStack(alignment: .leading) {
                    Text("Pseudonyme")
                        .fontWeight(.semibold)
                        .padding(.leading, 14)
                    TextField("Pseudonyme", text: $user.username)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding(14)
                        .glassEffect()
                }
                
                //LOCATION
                VStack(alignment: .leading) {
                    Text("Ville")
                        .fontWeight(.semibold)
                        .padding(.leading, 14)
                    TextField("Ville", text: Binding(
                        get: { user.userLocation ?? "" },
                        set: { user.userLocation = $0 }
                    ))
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding(14)
                    .glassEffect()
                }
                
                // BIO
                VStack(alignment: .leading) {
                    Text("Bio")
                        .fontWeight(.semibold)
                        .padding(.leading, 14)
                    
                    TextField("Bio", text: Binding(
                        get: { user.bio ?? "" },
                        set: { user.bio = $0 }
                    ))
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding(14)
                    .glassEffect()
                    .frame(maxWidth: 370)
                    .onChange(of: user.bio ?? "", { oldValue, newValue in
                        if newValue.count > 45 {
                            user.bio = String(newValue.prefix(45))
                        }
                    })
                }
                
                // Compteur de caractères
                HStack {
                    Spacer()
                    Text("\(user.bio?.count ?? 0)/45")
                        .foregroundColor(.gray)
                        .font(.caption)
                        .padding(.trailing, 14)
                }
                
                Spacer()
                
                // SAVE BUTTON
                Button(action: saveProfile) {
                    Text("Enregistrer")
                        .foregroundStyle(.white) // 👈 FIX
                        .frame(maxWidth: .infinity)
                        .padding()
                        .glassEffect(.regular.tint(.orange).interactive())
                        .cornerRadius(28)
                }
            }
            .padding()
            .onChange(of: selectedItem) { _, newItem in
                loadImage(from: newItem)
                }
            }
        }
        .navigationTitle("Modifier le profil")
        .navigationBarTitleDisplayMode(.large)
    }
}

extension EditProfileV {
    
    func loadImage(from item: PhotosPickerItem?) {
        guard let item else { return }
        
        Task {
            if let data = try? await item.loadTransferable(type: Data.self) {
                selectedImageData = data
            }
        }
    }
    
    func saveProfile() {
        print("Saving...")
    }
}

#Preview {
    NavigationStack {
        EditProfileV(user: User(
            username: "julien.serdaigle",
            userPic: nil,
            certification: true,
            userLocation: "Marseille",
            followers: 1200,
            following: 300,
            countReviews: 45,
            bio: "Music lover"
        ))
    }
}
