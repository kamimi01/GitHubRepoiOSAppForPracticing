//
//  ContentView.swift
//  GitHubRepoiOSAppForPracticing
//
//  Created by mika_admin on 2025-07-13.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewModel()

    var body: some View {
        List(viewModel.repos) {
            repoCard($0)
        }
        .task {
            Task {
                await viewModel.load()
            }
        }
    }
}

private extension ContentView {
    func repoCard(_ repo: Repository) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                AsyncImage(url: URL(string: repo.owner.imageURL)!) { result in
                    result.image?
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                }
                .frame(width: 70, height: 70)

                VStack(alignment: .leading, spacing: 5) {
                    Text(repo.name)
                    Text(repo.owner.name)
                        .foregroundStyle(.gray)
                }

                Spacer()

                Text("23")
//                Text("\(repo.numberOfStars)")
                    .bold()
            }

            Text(attributedDescription(repo.description ?? "N/A") ?? "Failed to fetch data")
                .lineLimit(2)
        }
        .padding(.vertical, 10)
    }

    func attributedDescription(_ text: String) -> AttributedString? {
        try? AttributedString(markdown: text)
    }
}

#Preview {
    ContentView()
}
