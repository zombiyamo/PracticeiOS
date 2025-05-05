//
//  Task+never.swift
//  GithubClient
//
//  Created by zombiyamo on 2025/05/05.
//

import Foundation

extension Task {
  static func never() async throws -> Success where Failure == Never {
    let stream = AsyncStream<Success> { _ in }
    for await element in stream {
      return element
    }
    throw _Concurrency.CancellationError()
  }
}
