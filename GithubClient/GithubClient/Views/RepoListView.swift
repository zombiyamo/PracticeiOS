//
//  RepoListView.swift
//  GithubClient
//
//  Created by zombiyamo on 2025/04/21.
//

import SwiftUI

struct RepoListView: View {
  @State var store = ReposStore()

  var body: some View {
    NavigationStack {
      if store.repos.isEmpty {
        ProgressView("Loading...")
      } else {
        List(store.repos) { repo in
          NavigationLink(value: repo) {
            RepoRow(repo: repo)
          }
        }
        .navigationTitle("Repositories")
        .navigationDestination(for: Repo.self) { repo in
          RepoDetailView(repo: repo)
        }
      }
    }
    .task {
      await store.loadRepos()
    }
  }
}

@Observable  // インスタンス内部の変更を監視
@MainActor  // クラス内の処理がメインスレッド上で実行されることが保証される
class ReposStore {
  private(set) var repos = [Repo]()

  func loadRepos() async {
    try! await Task.sleep(nanoseconds: 1_000_000_000)  // 1秒待つ

    repos = [.mock1, .mock2, .mock3, .mock4, .mock5]
  }
}

#Preview {
  RepoListView()
}
