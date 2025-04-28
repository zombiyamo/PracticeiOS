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
  let url = URL(string: "https://api.github.com/orgs/mixigroup/repos")!

  func loadRepos() async {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    urlRequest.allHTTPHeaderFields = [
      "Accept": "application/vnd.github.v3+json"
    ]
    // Github API のリクエスト制限(60回/h)回避のためのキャッシュ設定
    urlRequest.cachePolicy = .returnCacheDataElseLoad

    do {
      let (data, _) = try! await URLSession.shared.data(for: urlRequest)

      // デコード処理
      let jsonDecoder = JSONDecoder()
      jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
      repos = try jsonDecoder.decode([Repo].self, from: data)

    } catch {
      print("Failed to load repos: \(error)")
    }
  }
}

#Preview {
  RepoListView()
}
