//
//  Models.swift
//  GroupeArt
//
//  Created by Julien Estrada on 05/03/2026.
//

import Foundation

struct User: Identifiable {
    var id = UUID()
    let username: String
    let userPic: String?
    var certification: Bool
    let location: String?
    var followers: Int
    var following: Int
    var countReviews: Int
    let bio: String?
}

