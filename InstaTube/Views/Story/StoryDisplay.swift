//
//  StoryDisplay.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI
import AVKit

struct StoryDisplay: View {
    @State var player: AVPlayer?
    var story: Story
    
    var body: some View {
        switch story.type {
        case .image: imageStory
        case .video: videoStory
        }
    }
    
    var videoStory: some View {
        VideoPlayer(avPlayer: $player)
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
    
    var imageStory: some View {
        AsyncImage(url: URL(string: story.url)) { asyncImage in
            asyncImage
                .image?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        }
    }
}
