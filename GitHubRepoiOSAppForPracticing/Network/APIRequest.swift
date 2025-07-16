//
//  APIRequest.swift
//  GitHubRepoiOSAppForPracticing
//
//  Created by mika_admin on 2025-07-13.
//

import Foundation

// 1. Create a protocol of URLRequest

protocol APIRequest {
    // If I wanna put default implementations for baseURL or something, need to put only `get` no `set`
    var baseURL: URL { get }
    var path: String { get set }
    var httpMethod: HttpMethod { get set }
    var headers: [String: String] { get }
    var queries: [String: String]? { get }
}

enum URLRequestError: Error {
    case failedToCreateURL
}

extension APIRequest {
    var baseURL: URL {
        URL(string: "https://api.github.com")!
    }

    var headers: [String: String] {
        ["Accept": "application/vnd.github+json",
         "X-GitHub-Api-Version": "2022-11-28"]
    }

    var queries: [String: String]? {
        nil
    }

    func buildURLRequest() throws -> URLRequest {
        // 1. Create a URLComponents
        var components = URLComponents(string: baseURL.absoluteString)
        components?.path = path
        if let queries {
            components?.queryItems = queries.map { key, value in
                URLQueryItem(name: key, value: value)
            }
        }

        // 2. Create URL
        guard let url = components?.url
        else { throw URLRequestError.failedToCreateURL }

        // 3. Create URLRequest instance
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        // Don't use allHTTPHeaderFields because this API will reset the header fields not add.
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }
}
