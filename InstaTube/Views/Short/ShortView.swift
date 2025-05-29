//
//  ShortView.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI
import AVKit

struct ShortView: View {
    @State var avPlayer: AVPlayer?
    @State var avPlayerLooper: AVPlayerLooper?
    
    var short: Short
    
    var body: some View {
        GeometryReader { geometry in
            VideoPlayer(avPlayer: $avPlayer)
                .onAppear {
                    guard avPlayer == nil else { return }
                    guard let url = URL(string: short.url) else { return }
                    avPlayer = loop(url: url)
                    avPlayer?.play()
                }
                .onDisappear {
                    avPlayer = nil
                }
        }
    }
    
    func loop(url: URL) -> AVQueuePlayer {
        let templateItem = AVPlayerItem(url: url)
        let avPlayerQueue = AVQueuePlayer(playerItem: templateItem)
        avPlayerLooper = AVPlayerLooper(player: avPlayerQueue, templateItem: templateItem)
        return avPlayerQueue
    }
}

#Preview {
    ShortView(short: .fake1)
}
