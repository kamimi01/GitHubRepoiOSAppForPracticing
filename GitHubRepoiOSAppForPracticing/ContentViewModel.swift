//
//  ContentViewModel.swift
//  GitHubRepoiOSAppForPracticing
//
//  Created by mika_admin on 2025-07-13.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var repos: [Repository] = [
        Repository(name: "grit", numberOfStars: 23, owner: User(name: "mojombo", imageURL: URL(string: "https://avatars.githubusercontent.com/u/1?v=4")!), description: "**Grit is no longer maintained. Check out libgit2/rugged.** Grit gives you object oriented read/write access to Git repositories via Ruby."),
        Repository(name: "merb-core", numberOfStars: 34, owner: User(name: "wycats", imageURL: URL(string: "https://avatars.githubusercontent.com/u/4?v=4")!), description: "Merb Core: All you need. None you don't.")
    ]
}
