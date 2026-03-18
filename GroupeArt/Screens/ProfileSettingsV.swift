//
//  ProfileSettingsV.swift
//  GroupeArt
//
//  Created by BlueOneThree on 16/03/2026.
//

import SwiftUI

// Settings Rows
struct SettingsRow: View {
    let label: String

    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.semibold)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.footnote)
        }
        .padding(16)
        .glassEffect()
    }
}

struct ProfileSettingsV: View {
    @State private var password = "groupeArt777"
    @State private var email = "julienserdaigle@exemple.com"
    @State private var showPassword = false
    
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

            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {

                    // Password
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Mot de passe")
                            .fontWeight(.semibold)
                            .padding(.leading, 16)

                        HStack {
                            Group {
                                if showPassword {
                                    TextField("Mot de passe", text: $password)
                                } else {
                                    SecureField("Mot de passe", text: $password)
                                }
                            }
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)

                            Button {
                                showPassword.toggle()
                            } label: {
                                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(14)
                        .glassEffect()
                    }

                    // Mail address
                    VStack(alignment: .leading, spacing: 6) {
                        Text("E-mail")
                            .fontWeight(.semibold)
                            .padding(.leading, 16)

                        TextField("Entrer une adresse mail", text: $email)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .padding(14)
                            .glassEffect()
                    }

                    // Rows
                    VStack(spacing: 10) {
                        SettingsRow(label: "Notifications")
                        SettingsRow(label: "Aide")
                        SettingsRow(label: "Paramètres de confidentialité")
                        SettingsRow(label: "Langue")
                        SettingsRow(label: "À propos")
                    }
                    .padding(.top, 8)

                    // Actions
                    VStack(spacing: 16) {
                        Button("DÉCONNEXION") {}
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .glassEffect()

                        Button("SUPPRIMER LE COMPTE") {}
                            .foregroundColor(.black)
                            .fontWeight(.regular)
                    }
                    .padding(.top, 24)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("Paramètres")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        ProfileSettingsV()
    }
}
