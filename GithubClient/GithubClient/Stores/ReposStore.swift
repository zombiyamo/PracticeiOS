//
//  ReposStore.swift
//  GithubClient
//
//  Created by zombiyamo on 2025/05/05.
//
import Observation

@Observable  // インスタンス内部の変更を監視
@MainActor  // クラス内の処理がメインスレッド上で実行されることが保証される
class ReposStore {
  enum Action {
    case onAppear
    case onRetryButtonTapped
  }

  private(set) var state: Stateful<[Repo]> = .loading

  private let apiClient: any RepositoryHandling

  init(apiClient: any RepositoryHandling) {
    self.apiClient = apiClient
  }

  func loadRepos() async {
    state = .loading
    do {
      let repos = try await apiClient.getRepos()
      state = .loaded(repos)
    } catch {
      print("Failed to load repos: \(error)")
      state = .failed(error)
    }
  }

  func send(_ action: Action) async {
    switch action {
    case .onAppear:
      await loadRepos()
    case .onRetryButtonTapped:
      await loadRepos()
    }
  }
}
