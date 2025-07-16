//
//  RepositoryListRequest.swift
//  GitHubRepoiOSAppForPracticing
//
//  Created by mika_admin on 2025-07-13.
//

import Foundation

struct RepositoryListRequest: APIRequest {
    typealias response = [Repository]

    var path: String = "/repositories"
    var httpMethod: HttpMethod = .get
}
