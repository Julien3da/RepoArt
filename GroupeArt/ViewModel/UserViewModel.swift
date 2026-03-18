//
//  UserViewModel.swift
//  GroupeArt
//
//  Created by apprenant84 on 10/03/2026.
//

import Foundation
import Observation

@Observable @MainActor
class UserViewModel {
    private let apiKey = "patOE0Bk62hEWC6uu.2463aca8589573d9a241d1f41caee3651b50c658023d5bfaa2092de96a1894f3"
    private let baseURL = URL(string: "https://api.airtable.com/v0/appfvBclieq9JmBZF/User")!

    var users: [User] = []

    func fetchUsers() async throws -> [User] {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            let decoded = try decoder.decode(UserReponse.self, from: data)
        
            let users = decoded.records.map { record -> User in
                var user = record.fields
                user.recordId = record.id
                return user
            }
            self.users = users
            return users
        } catch {
            print("Échec du décodage: \(error)")
            throw error
        }
    }
}
