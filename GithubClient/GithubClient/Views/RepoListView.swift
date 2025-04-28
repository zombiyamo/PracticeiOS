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
                  await store.loadRepos()
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
      await store.loadRepos()
    }
  }
}

enum Stateful<Value> {
  /// 読込中
  case loading
  /// 読み込み失敗、遭遇したエラーを保持
  case failed(Error)
  /// 読み込み完了、読み込まれた値を保持
  case loaded(Value)
}

@Observable  // インスタンス内部の変更を監視
@MainActor  // クラス内の処理がメインスレッド上で実行されることが保証される
class ReposStore {
  private(set) var state: Stateful<[Repo]> = .loading
  let url = URL(string: "https://api.github.com/orgs/mixigroup/repos")!

  func loadRepos() async {
    state = .loading
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    urlRequest.allHTTPHeaderFields = [
      "Accept": "application/vnd.github.v3+json"
    ]
    // Github API のリクエスト制限(60回/h)回避のためのキャッシュ設定
    urlRequest.cachePolicy = .returnCacheDataElseLoad

    do {
      let (data, response) = try await URLSession.shared.data(for: urlRequest)
      guard let response = response as? HTTPURLResponse,
        response.statusCode == 200
      else {
        throw URLError(.badServerResponse)
      }

      // デコード処理
      let jsonDecoder = JSONDecoder()
      jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
      state = .loaded(try jsonDecoder.decode([Repo].self, from: data))
    } catch {
      print("Failed to load repos: \(error)")
      state = .failed(error)
    }
  }
}

#Preview {
  RepoListView()
}
