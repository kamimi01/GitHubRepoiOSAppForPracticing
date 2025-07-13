//
//  Repository.swift
//  GitHubRepoiOSAppForPracticing
//
//  Created by mika_admin on 2025-07-13.
//

import Foundation

struct Repository: Codable, Identifiable {
    var id: String { UUID().uuidString }
    let name: String
//    let numberOfStars: Int = 100
    let owner: User
    let description: String?
}

struct User: Codable {
    let name: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case name = "login"
        case imageURL = "avatar_url"
    }
}
