//
//  RepoAPIClient.swift
//  GithubClient
//
//  Created by zombiyamo on 2025/05/05.
//

import Foundation

struct RepoAPIClient {
  let url = URL(string: "https://api.github.com/orgs/mixigroup/repos")!
  func getRepos() async throws -> [Repo] {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    urlRequest.allHTTPHeaderFields = [
      "Accept": "application/vnd.github.v3+json"
    ]
    // Github API のリクエスト制限(60回/h)回避のためのキャッシュ設定
    urlRequest.cachePolicy = .returnCacheDataElseLoad

    let (data, response) = try await URLSession.shared.data(for: urlRequest)
    guard let response = response as? HTTPURLResponse,
      response.statusCode == 200
    else {
      throw URLError(.badServerResponse)
    }

    // デコード処理
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    return try jsonDecoder.decode([Repo].self, from: data)
  }
}
