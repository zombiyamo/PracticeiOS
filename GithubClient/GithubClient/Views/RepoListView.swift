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
      Group {
        if store.error != nil {
          VStack {
            Text("Failed to load repositories")
            Button(
              action: {
                Task {
                  // リトライボタンをタップしたときに再度リクエストを投げる
                  await store.loadRepos()
                }
              },
              label: {
                Text("Retry")
              }
            )
            .padding()
          }
        } else {
          if store.isLoading {
            ProgressView("Loading...")
          } else {
            List(store.repos) { repo in
              NavigationLink(value: repo) {
                RepoRow(repo: repo)
              }
            }
          }
        }
      }
      .navigationTitle("Repositories")
      .navigationDestination(for: Repo.self) { repo in
        RepoDetailView(repo: repo)
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
  private(set) var error: Error? = nil
  private(set) var isLoading: Bool = false
  let url = URL(string: "https://api.github.com/orgs/mixigroup/repos")!

  func loadRepos() async {
    isLoading = true
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    urlRequest.allHTTPHeaderFields = [
      "Accept": "application/vnd.github.v3+json"
    ]
    // Github API のリクエスト制限(60回/h)回避のためのキャッシュ設定
    urlRequest.cachePolicy = .returnCacheDataElseLoad

    do {
      let (data, response) = try await URLSession.shared.data(for: urlRequest)
      //      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
      throw URLError(.badServerResponse)
      //      }

      // デコード処理
      let jsonDecoder = JSONDecoder()
      jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
      repos = try jsonDecoder.decode([Repo].self, from: data)
      isLoading = false
    } catch {
      print("Failed to load repos: \(error)")
      self.error = error
      isLoading = false
    }
  }
}

#Preview {
  RepoListView()
}
