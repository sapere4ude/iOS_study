//
//  FeedListView.swift
//  ExEventPublisher
//
//  Created by Kant on 7/15/25.
//

import SwiftUI
import Combine

struct FeedListView: View {
    @State private var likedPostIDs: Set<String> = []
    @State private var cancellables = Set<AnyCancellable>()

    let allPostIDs = ["post1", "post2", "post3"]

    var body: some View {
        NavigationView {
            List(allPostIDs, id: \.self) { id in
                NavigationLink(destination: DetailView(postID: id)) {
                    HStack {
                        Text("📝 \(id)")
                        Spacer()
                        if likedPostIDs.contains(id) {
                            Text("❤️")
                        }
                    }
                }
            }
            .navigationTitle("피드 리스트")
        }
        .onAppear {
            GlobalEventBridge.shared.likePublisher
                .receive(on: RunLoop.main)
                .sink { event in
                    switch event {
                    case let .liked(postID):
                        likedPostIDs.insert(postID)
                    case let .unliked(postID):
                        likedPostIDs.remove(postID)
                    }
                }
                .store(in: &cancellables)
        }
    }
}
