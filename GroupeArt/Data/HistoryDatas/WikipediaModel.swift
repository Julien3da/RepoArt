//
//  WikipediaModel.swift
//  GroupeArt
//
//  Created by FUVE on 12/03/2026.
//

import Foundation

struct WikipediaResponse: Codable {
    let thumbnail: WikipediaThumbnail?
    let extract: String?
}

struct WikipediaThumbnail: Codable {
    let source: String?
}

