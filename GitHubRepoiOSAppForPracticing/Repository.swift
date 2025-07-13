//
//  Repository.swift
//  GitHubRepoiOSAppForPracticing
//
//  Created by mika_admin on 2025-07-13.
//

import Foundation

struct Repository: Codable {
    let name: String
    let numberOfStars: Int
    let owner: User
    let description: String
}

struct User: Codable {
    let name: String
    let imageURL: URL
}
