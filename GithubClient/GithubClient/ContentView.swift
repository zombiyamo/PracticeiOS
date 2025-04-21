//
//  ContentView.swift
//  GithubClient
//
//  Created by zombiyamo on 2025/04/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                    .font(.title)
                    .foregroundStyle(.blue)
                    .fontWeight(.bold)
            }
            Text("Good evening, world!!")
                .font(.system(size: 11, weight: .bold)) // 11pt is iOS Mimimum size.
                .foregroundStyle(.red)
            Text("Good morning, world!!")
                .font(.system(size: 17, weight: .bold)) // 11pt is iOS Default size.
                .foregroundStyle(.green)
            // Dynamic Type は Largeがデフォルト
            // https://developer.apple.com/design/human-interface-guidelines/typography#Specifications
        }
    }
}

#Preview {
    ContentView()
}
