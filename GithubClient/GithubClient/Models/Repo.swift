//
//  Repo.swift
//  GithubClient
//
//  Created by zombiyamo on 2025/04/21.
//

import Foundation

struct Repo: Identifiable, Hashable {
  var id: Int  //idの型はHashableに準拠していればなんでも良い
  var name: String
  var owner: User
  var description: String?  // OptionalはGitHubAPIのレスポンス仕様に準拠しているため
  var stargazersCount: Int
}
