//
//  ShortView.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI
import AVKit

struct ShortView: View {
    @Binding var short: Short
    @State var player: AVPlayer?
    @State var playerLooper: AVPlayerLooper?
    
    @StateObject var viewModel: ShortViewModel = .init()
    
    var body: some View {
        GeometryReader { geometry in
            let frame = geometry.frame(in: .scrollView(axis: .vertical))
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
                .preference(key: ViewOffsetPreferenceKey.self, value: frame)
                .onPreferenceChange(ViewOffsetPreferenceKey.self, perform: { value in
                    shouldPlayVideo(value: value) ? player?.play() : player?.pause()
                })
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
                                
                                Task {
                                    let result = await viewModel.likeShort(shortId: short.id)
                                    if !result {
                                        short.liked = !short.liked
                                    }
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
                .cornerRadius(50)
        }
    }
}

// Loop Video
private extension ShortView {
    func shouldPlayVideo(value: CGRect) -> Bool {
        let minPositive = value.minY
        let minNegative = -value.minY
        let half = value.height / 2
        let isVisible = (minPositive < half) && (minNegative < half)
        return isVisible
    }
    
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
