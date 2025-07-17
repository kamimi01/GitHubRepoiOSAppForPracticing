//
//  SearchRepository.swift
//  GitHubRepoiOSAppForPracticing
//
//  Created by mika_admin on 2025-07-17.
//

struct SearchedRepository: Codable {
    let totalCount: Int
    let items: [Repository]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
