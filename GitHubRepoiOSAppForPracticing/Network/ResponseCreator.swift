//
//  ResponseCreator.swift
//  GitHubRepoiOSAppForPracticing
//
//  Created by mika_admin on 2025-07-16.
//

import Foundation

enum ResponseCreatorError: Error {
    case failedToConvertHTTPURLResponse
    case redirectionNeeded
    case invalidRequest
    case server
    case unexpected
}

final class ResponseCreator<Request: APIRequest> {
    func createResponse(for request: Request) async throws -> Request.response {
        let urlRequest = try request.buildURLRequest()

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ResponseCreatorError.failedToConvertHTTPURLResponse
        }

        switch httpResponse.statusCode {
        case (0...299):
            let decorder = JSONDecoder()
            let response = try decorder.decode(Request.response.self, from: data)
            return response
        case (300...399):
            throw ResponseCreatorError.redirectionNeeded
        case (400...499):
            throw ResponseCreatorError.invalidRequest
        case (500...599):
            throw ResponseCreatorError.server
        default:
            throw ResponseCreatorError.unexpected
        }
    }
}
