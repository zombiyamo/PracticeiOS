//
//  RepoListView.swift
//  GithubClient
//
//  Created by zombiyamo on 2025/04/21.
//

import SwiftUI

struct RepoListView: View {
  private let mockRepos: [Repo] = [
    .mock1,
    .mock2,
    .mock3,
    .mock4,
    .mock5,
  ]

  var body: some View {
    List(mockRepos) { repo in
      RepoRow(repo: repo)
    }
  }
}

#Preview {
  RepoListView()
}
