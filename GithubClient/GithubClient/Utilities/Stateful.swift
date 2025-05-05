//
//  Stateful.swift
//  GithubClient
//
//  Created by zombiyamo on 2025/05/05.
//
import Foundation

enum Stateful<Value> {
  /// 読込中
  case loading
  /// 読み込み失敗、遭遇したエラーを保持
  case failed(Error)
  /// 読み込み完了、読み込まれた値を保持
  case loaded(Value)
}
