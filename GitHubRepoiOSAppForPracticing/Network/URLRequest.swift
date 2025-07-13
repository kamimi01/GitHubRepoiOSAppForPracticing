//
//  APIRequest.swift
//  GitHubRepoiOSAppForPracticing
//
//  Created by mika_admin on 2025-07-13.
//

import Foundation

// 1. Create a protocol of URLRequest

protocol URLRequest {
    var baseURL: URL { get set }
    var path: String { get set }
    var httpMethod: HttpMethod { get set }
    var headers: [String: String] { get set }
}

extension URLRequest {
    var baseURL: URL {
        URL(string: "https://api.github.com")!
    }

    var headers: [String: String] {
        ["Accept": "application/vnd.github+json",
         "X-GitHub-Api-Version": "2022-11-28"]
    }
}
