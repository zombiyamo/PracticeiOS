//
//  RepoListView.swift
//  GithubClient
//
//  Created by zombiyamo on 2025/04/21.
//

import SwiftUI

struct RepoListView: View {
  @State var store: ReposStore

  var body: some View {
    NavigationStack {
      Group {
        switch store.state {
        case .loading:
          ProgressView("Loading...")
        case .loaded(let repos):
          List(repos) { repo in
            NavigationLink(value: repo) {
              RepoRow(repo: repo)
            }
          }
        case .failed:
          VStack {
            Text("Failed to load repositories")
            Button(
              action: {
                Task {
                  // リトライボタンをタップしたときに再度リクエストを投げる
                  await store.send(.onRetryButtonTapped)
                }
              },
              label: {
                Text("Retry")
              }
            )
            .padding()
          }
        }
      }
      .navigationTitle("Repositories")
      .navigationDestination(for: Repo.self) { repo in
        RepoDetailView(repo: repo)
      }
    }
    .task {
      await store.send(.onAppear)
    }
  }
}

#Preview("正常系") {
  RepoListView(
    store: ReposStore(
      apiClient: MockRepoAPIClient(
        getRepos: {
          [.mock1, .mock2, .mock3, .mock4, .mock5]
        }
      )
    )
  )
}

#Preview("読込中") {
  RepoListView(
    store: ReposStore(
      apiClient: MockRepoAPIClient(
        getRepos: {
          try await Task.never()
        }
      )
    )
  )
}

#Preview("エラー") {
  RepoListView(
    store: ReposStore(
      apiClient: MockRepoAPIClient(
        getRepos: {
          throw DummyError()
        }
      )
    )
  )
}
