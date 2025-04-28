//
//  RepoDetailView.swift
//  GithubClient
//
//  Created by zombiyamo on 2025/04/21.
//

import Foundation
import SwiftUI

struct RepoDetailView: View {
  let repo: Repo
  @ScaledMetric(relativeTo: .caption)
  private var imageHeight = 16

  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        HStack(spacing: 2) {
          // ここでrepo.owner.imageURLを表示する
          AsyncImage(url: repo.owner.imageURL) { phase in
            switch phase {
            case .empty:
              ProgressView()
                .frame(height: imageHeight)
            case .success(let image):
              image
                .resizable()
                .scaledToFit()
                .frame(height: imageHeight)
            case .failure:
              Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(height: imageHeight)
            @unknown default:
              EmptyView()
            }
          }
          Text(repo.owner.name)
            .font(.caption)
        }

        Text(repo.name)
          .font(.body)
          .fontWeight(.bold)
        if let description = repo.description {
          Text(description)
            .padding(.top, 4)
        }
        HStack {
          Image(systemName: "star")
          Text("\(repo.stargazersCount)")
        }
        .padding(.top, 8)
        Spacer()
      }
      Spacer()
    }
    .padding(8)
    .navigationTitle("Repository Detail")
  }
}

#Preview {
  RepoDetailView(repo: .mock1)
}
