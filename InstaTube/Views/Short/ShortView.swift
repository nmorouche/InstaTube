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
    
    @Binding var short: Short
    
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
                .overlay {
                    HStack(alignment: .center) {
                        Spacer()
                        VStack(alignment: .trailing,
                               spacing: 32) {
                            Spacer()
                            Button {
                                withAnimation {
                                    short.liked = !short.liked
                                }
                            } label: {
                                Image(systemName: short.liked ? "heart.fill" : "heart")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                            }
                        }
                               .padding(.bottom, 50)
                               .padding(.trailing, 25)
                               .tint(.gray)
                    }
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
    ShortView(short: .constant(.fake1))
}
