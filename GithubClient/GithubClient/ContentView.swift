//
//  ContentView.swift
//  GithubClient
//
//  Created by zombiyamo on 2025/04/21.
//

import SwiftUI

struct ContentView: View {
    private let mockRepos = [
        Repo(name: "Test Repo1", owner: User(name: "Test User1")),
        Repo(name: "Test Repo2", owner: User(name: "Test User2")),
        Repo(name: "Test Repo3", owner: User(name: "Test User3")),
        Repo(name: "Test Repo4", owner: User(name: "Test User4")),
        Repo(name: "Test Repo5", owner: User(name: "Test User5")),
    ]
    
    
    var body: some View {
        List(0 ..< 5) { item in
            HStack {
                Image(.githubMark)
                    .resizable()
                    .frame(
                        width: 44.0,
                        height: 44.0
                    )
                VStack(alignment: .leading) {
                    Text("Owner Name")
                        .font(.caption)
                    Text("Repository Name")
                        .font(.body)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
