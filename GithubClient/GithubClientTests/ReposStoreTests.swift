//
//  ReposStoreTests.swift
//  ReposStoreTests
//
//  Created by zombiyamo on 2025/04/21.
//

import Testing

@testable import GithubClient

struct ReposStoreTests {
  @MainActor
  @Test func onAppear_正常系() async {
    let store = ReposStore(
      apiClient: MockRepoAPIClient(
        getRepos: { [.mock1, .mock2] }
      )
    )

    await store.send(.onAppear)

    switch store.state {
    case .loaded(let repos):
      #expect(repos == [.mock1, .mock2])
    default:
      Issue.record("state should be `.loaded`")
    }
  }

  @MainActor
  @Test func onAppear_異常系() async {
    struct DummyError: Error {}
    let dummyError = DummyError()

    let store = ReposStore(
      apiClient: MockRepoAPIClient(
        getRepos: { throw dummyError }
      )
    )

    await store.send(.onAppear)

    switch store.state {
    case .failed(let error):
      #expect(error is DummyError)
    default:
      Issue.record("state should be `.failed`")
    }
  }

  struct MockRepoAPIClient: RepositoryHandling {
    var getRepos: @Sendable () async throws -> [Repo]

    func getRepos() async throws -> [Repo] {
      try await getRepos()
    }
  }
}
