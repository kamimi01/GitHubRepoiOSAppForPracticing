//
//  ResponseCreator.swift
//  GitHubRepoiOSAppForPracticing
//
//  Created by mika_admin on 2025-07-16.
//

import Foundation

enum GitHubClientError: Error {
    case connection
    case unexpected(statusCode: Int)
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

        try validate(data: data, response: response)

        return try decorder.decode(Request.response.self, from: data)
    }

    private func validate(data: Data, response: URLResponse) throws {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw GitHubClientError.connection
        }

        if !(200...299).contains(statusCode) {
            throw GitHubClientError.unexpected(statusCode: statusCode)
        }
    }
}
