//
//  RepoListView.swift
//  GithubClient
//
//  Created by zombiyamo on 2025/04/21.
//

import SwiftUI

struct RepoListView: View {
  @State private var mockRepos: [Repo] = []

  var body: some View {
    NavigationStack {
      if mockRepos.isEmpty {
        ProgressView("Loading...")
      } else {
        List(mockRepos) { repo in
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
    .onAppear {
      loadRepos()
    }
  }

  private func loadRepos() {
    // 1秒後にモックデータを読み込む
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
      mockRepos = [.mock1, .mock2, .mock3, .mock4, .mock5]
    }
  }
}

#Preview {
  RepoListView()
}
