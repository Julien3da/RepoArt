//
//  ReviewViewModel.swift
//  GroupeArt
//
//  Created by apprenant84 on 10/03/2026.
//

import Foundation
import Observation

@Observable @MainActor
class ReviewViewModel {
    private let apiKey = "patOE0Bk62hEWC6uu.2463aca8589573d9a241d1f41caee3651b50c658023d5bfaa2092de96a1894f3"
    private let baseURL = URL(string: "https://api.airtable.com/v0/appfvBclieq9JmBZF/Review")!

    var reviews: [Review] = []
    var isPosting = false
    var error: Error?
    var success = false
    var isLoading = false

    // Current User
    private let hardcodedUserId = "recwAC44d2sQ2kwql"
    
    private func makeRequest(url: URL, method: String = "GET") -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        if method == "POST" {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }

    func fetchUserReviews(forUsername username: String) async throws -> [Review] {
        self.reviews = []
        var components = URLComponents(string: baseURL.absoluteString)!
        components.queryItems = [
            URLQueryItem(
                name: "filterByFormula",
                value: "FIND(\"\(username)\", ARRAYJOIN({User}))"
            )
        ]
        
        guard let url = components.url else { return [] }
        
        print("URL appelée: \(url)")
        
        let (data, _) = try await URLSession.shared.data(for: makeRequest(url: url))
        
        print("Raw JSON: \(String(data: data, encoding: .utf8) ?? "nil")")
        
        let decoded = try JSONDecoder().decode(ReviewReponse.self, from: data)
        
        print("Reviews count: \(decoded.records.count)")
        
        let reviews = decoded.records.map { record -> Review in
            var review = record.fields
            review.recordId = record.id
            review.id = record.id
            return review
        }
        self.reviews = reviews
        return reviews
    }
  
    func fetchReviews() async throws -> [Review] {

        isLoading = true
        defer { isLoading = false }

        var request = URLRequest(url: baseURL)
                request.httpMethod = "GET"
                request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

                let (data, _) = try await URLSession.shared.data(for: request)

                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601

                do {
                    let decoded = try decoder.decode(ReviewReponse.self, from: data)
                    let reviews = decoded.records.map { record -> Review in
                        var review = record.fields
                        return review
                    }
                    self.reviews = reviews
                    return reviews
                } catch {
                    print("Échec du décodage: (error)")
                    print("❌ JSON brut :", String(data: data, encoding: .utf8) ?? "")
                    throw error
                }

    }

    func postReview(album: Album, mark: Int, reviewTitle: String, reviewText: String?) async {
        guard let albumRecordId = album.airtableID else {
            print("Missing album recordId")
            return
        }

        isPosting = true
        defer { isPosting = false }

        var fields: [String: Any] = [
            "markReview": mark,
            "reviewTitle": reviewTitle,
            "Album": [albumRecordId],
            "user": [hardcodedUserId]
        ]

        // userReview facultatif
        if let text = reviewText, !text.trimmingCharacters(in: .whitespaces).isEmpty {
            fields["userReview"] = text
        }

        let body: [String: Any] = [
            "records": [["fields": fields]]
        ]

        var request = makeRequest(url: baseURL, method: "POST")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            if let http = response as? HTTPURLResponse {
                success = http.statusCode == 200
                if success { print("Review posted successfully") }
            }
        } catch {
            self.error = error
            print("Error posting review: \(error)")
        }
    }
}
