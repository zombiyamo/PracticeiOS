//
//  MockRepoAPIClient.swift
//  GithubClient
//
//  Created by zombiyamo on 2025/05/05.
//
import Foundation

struct MockRepoAPIClient: RepositoryHandling {
  var getRepos: @Sendable () async throws -> [Repo]

  func getRepos() async throws -> [Repo] {
    try await getRepos()
  }
}
