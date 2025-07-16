//
//  ContentViewModel.swift
//  GitHubRepoiOSAppForPracticing
//
//  Created by mika_admin on 2025-07-13.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var repos: [Repository] = []

    func load() async {
        do {
            let responseCreator = ResponseCreator<RepositoryListRequest>()
            let request = RepositoryListRequest()
            let repos = try await responseCreator.createResponse(for: request)

            await MainActor.run { [weak self] in
                self?.repos = repos
            }
        } catch {
            // FIXME: implement error
            print(error)
        }
    }
}
