//
//  ShortView.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI
import AVKit

struct ShortView: View {
    @State var player: AVPlayer?
    @State var playerLooper: AVPlayerLooper?
    
    var short: Short
    
    var body: some View {
        GeometryReader { geometry in
            VideoPlayer(player: $player)
                .onAppear {
                    guard player == nil,
                          let url = URL(string: short.url) else { return }

                    player = loop(url: url)
                    player?.play()
                }
                .onDisappear {
                    player = nil
                }
        }
    }
}

// Loop Video
private extension ShortView {
    func loop(url: URL) -> AVQueuePlayer {
        let templateItem = AVPlayerItem(url: url)
        let playerQueue = AVQueuePlayer(playerItem: templateItem)
        playerLooper = AVPlayerLooper(player: playerQueue, templateItem: templateItem)
        return playerQueue
    }
}

#Preview {
    ShortView(short: .fake1)
}
