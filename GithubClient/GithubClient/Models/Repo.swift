//
//  Repo.swift
//  GithubClient
//
//  Created by zombiyamo on 2025/04/21.
//

import Foundation

struct Repo: Identifiable {
  var id: Int //idの型はHashableに準拠していればなんでも良い
  var name: String
  var owner: User
}
