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
        let request = RepositoryListRequest()

        do {
            let urlRequest = try request.buildURLRequest()
            // FIXME: implement this somewhere else
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case (0...299):
                    print("do nothing")
                // FIXME: implement more patterns like 300, 400, 500
                default:
                    // FIXME: implement error
                    print("status code is not 0 to 299: \(httpResponse.statusCode)")
                }
            }

            let decorder = JSONDecoder()
            let repos = try decorder.decode([Repository].self, from: data)

            await MainActor.run { [weak self] in
                self?.repos = repos
            }
        } catch {
            // FIXME: implement error
            print(error)
        }
    }
}
