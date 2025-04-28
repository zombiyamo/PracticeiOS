//
//  User.swift
//  GithubClient
//
//  Created by zombiyamo on 2025/04/21.
//

import Foundation

struct User: Hashable, Decodable {
  var name: String
  var imageURL: URL

  private enum CodingKeys: String, CodingKey {
    case name = "login"
    case imageURL = "avatarUrl"
  }
}
