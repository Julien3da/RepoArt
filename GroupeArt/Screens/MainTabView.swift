//
//  MainTabView.swift
//  GroupeArt
//
//  Created by BlueOneThree on 17/03/2026.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("Feed", systemImage: "music.note.house.fill") {
                FeedView()
            }
            Tab("Listes", systemImage: "list.bullet.rectangle.fill"){
                AllListView()
            }
            Tab("Historique", systemImage: "music.note.list"){
                HistoryView()
            }
            Tab("Profil", systemImage: "person.fill"){
                ProfilUserView()
            }
        }
    }
}

#Preview {
    MainTabView()
}
