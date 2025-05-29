//
//  StoryDisplay.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI
import AVKit

struct StoryDisplay: View {
    @State private var player: AVPlayer?
    var story: Story
    
    var body: some View {
        switch story.type {
        case .image: imageStory
        case .video: videoStory
        }
    }
    
    private var videoStory: some View {
        VideoPlayer(player: $player)
            .onAppear {
                guard player == nil,
                      let url = URL(string: story.url) else { return }
                player = AVPlayer(url: url)
                player?.play()
            }
            .onDisappear {
                player = nil
            }
            .ignoresSafeArea()
    }
    
    private var imageStory: some View {
        AsyncImage(url: URL(string: story.url)) { asyncImage in
            asyncImage
                .image?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        }
    }
}
