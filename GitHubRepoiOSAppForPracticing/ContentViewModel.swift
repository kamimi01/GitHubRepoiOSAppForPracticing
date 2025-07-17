//
//  ContentViewModel.swift
//  GitHubRepoiOSAppForPracticing
//
//  Created by mika_admin on 2025-07-13.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var repos: [Repository] = []
    private let client = GitHubClient()

    func load() async {
        do {
            let request = GitHubAPI.RepositoryList()
            let repos = try await client.send(request: request)

            await MainActor.run { [weak self] in
                self?.repos = repos
            }
        } catch {
            // FIXME: implement error
            print(error)
        }
    }

//    func search() async {
//        do {
//            let request = GitHubAPI.SearchRepository(with: <#T##String#>)
//        }
//    }
}
