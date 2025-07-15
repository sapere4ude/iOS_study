//
//  DetailView.swift
//  ExEventPublisher
//
//  Created by Kant on 7/15/25.
//

import SwiftUI

struct DetailView: View {
    let postID: String

    var body: some View {
        VStack(spacing: 20) {
            Button("❤️ 좋아요 누르기") {
                GlobalEventBridge.shared.sendLikeEvent(.liked(postID: postID))
            }
            Button("💔 좋아요 취소") {
                GlobalEventBridge.shared.sendLikeEvent(.unliked(postID: postID))
            }
        }
        .padding()
    }
}
