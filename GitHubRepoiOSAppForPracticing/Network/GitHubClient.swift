//
//  ResponseCreator.swift
//  GitHubRepoiOSAppForPracticing
//
//  Created by mika_admin on 2025-07-16.
//

import Foundation

enum GitHubClientError: Error {
    case failedToConvertHTTPURLResponse
    case redirectionNeeded
    case invalidRequest
    case server
    case unexpected
}

final class GitHubClient {
    // Avoid creating an instance for every request
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()

    private let decorder: JSONDecoder = {
        let decorder = JSONDecoder()
        return decorder
    }()

    func send<Request: APIRequest>(request: Request) async throws -> Request.response {
        let urlRequest = try request.buildURLRequest()

        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw GitHubClientError.failedToConvertHTTPURLResponse
        }

        switch httpResponse.statusCode {
        case (0...299):
            let response = try decorder.decode(Request.response.self, from: data)
            return response
        case (300...399):
            throw GitHubClientError.redirectionNeeded
        case (400...499):
            throw GitHubClientError.invalidRequest
        case (500...599):
            throw GitHubClientError.server
        default:
            throw GitHubClientError.unexpected
        }
    }
}
