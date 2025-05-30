//
//  StoryContentView.swift
//  InstaTube
//
//  Created by Nassim Morouche on 30/05/2025.
//

import SwiftUI
import AVKit

struct StoryContentView: View {
    @State var player: AVPlayer?
    @Binding var users: [User]
    @Binding var tabIndex: Int
    private var onNext: (() -> Void)?
    private var onPrevious: (() -> Void)?
    private var onDismiss: (() -> Void)?
    
    @StateObject var viewModel: StoryContentViewModel
    
    init(currentUserIndex: Int, users: Binding<[User]>, tabIndex: Binding<Int>, onNext: (() -> Void)? = nil, onPrevious: (() -> Void)? = nil, onDismiss: (() -> Void)? = nil) {
        _viewModel = StateObject(wrappedValue: StoryContentViewModel(currentUserIndex: currentUserIndex))
        self._users = users
        self._tabIndex = tabIndex
        self.onNext = onNext
        self.onPrevious = onPrevious
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    ForEach(0..<users[viewModel.currentUserIndex].stories.count, id: \.self) { index in
                        if (index < viewModel.currentStory) {
                            ProgressView(value: 1)
                        } else if (index > viewModel.currentStory) {
                            ProgressView(value: 0)
                        } else {
                            ProgressView(value: viewModel.progress)
                        }
                    }
                }
                HStack(alignment: .center) {
                    CircleImage(imageUrl: users[viewModel.currentUserIndex].profilePictureUrl)
                    Text(users[viewModel.currentUserIndex].name)
                    Spacer()
                    Button("", systemImage: "xmark") {
                        onDismiss?()
                    }
                    .tint(.gray)
                }
                Spacer()
            }
            .padding()
            .background(content: {
                StoryMedia(player: $player, story: users[viewModel.currentUserIndex].stories[viewModel.currentStory])
            })
            .overlay {
                HStack(alignment: .center) {
                    Spacer()
                    VStack(alignment: .trailing,
                           spacing: 32) {
                        Spacer()
                        Button {
                            withAnimation {
                                users[viewModel.currentUserIndex].stories[viewModel.currentStory].liked = !users[viewModel.currentUserIndex].stories[viewModel.currentStory].liked
                            }
                        } label: {
                            Image(systemName: users[viewModel.currentUserIndex].stories[viewModel.currentStory].liked ? "heart.fill" : "heart")
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
            .onAppear() {
                users[viewModel.currentUserIndex].stories[viewModel.currentStory].seen = true
                viewModel.usersCount = users.count
                viewModel.storiesCount = users[viewModel.currentUserIndex].stories.count
                viewModel.duration = users[viewModel.currentUserIndex].stories[viewModel.currentStory].duration
                viewModel.useTimer()
            }
            .onTapGesture { location in
                let point = location.x
                let fullScreen = geo.size.width
                let half = fullScreen / 2
                if point > half {
                    viewModel.nextStory()
                    users[viewModel.currentUserIndex].stories[viewModel.currentStory].seen = true
                    player?.replaceCurrentItem(with: AVPlayerItem(url: URL(string: users[viewModel.currentUserIndex].stories[viewModel.currentStory].url)!))
                } else {
                    viewModel.previousStory()
                    users[viewModel.currentUserIndex].stories[viewModel.currentStory].seen = true
                    player?.replaceCurrentItem(with: AVPlayerItem(url: URL(string: users[viewModel.currentUserIndex].stories[viewModel.currentStory].url)!))
                }
            }
            .onChange(of: viewModel.shouldTriggerOnNextAction) { oldValue, newValue in
                if oldValue == false && newValue {
                    viewModel.shouldTriggerOnNextAction = false
                    withAnimation {
                        onNext?()
                    }
                }
            }
            .onChange(of: viewModel.shouldTriggerOnPreviousAction) { oldValue, newValue in
                if oldValue == false && newValue {
                    viewModel.shouldTriggerOnPreviousAction = false
                    withAnimation {
                        onPrevious?()
                    }
                }
            }
            .onChange(of: viewModel.shouldDismiss) {
                withAnimation {
                    onDismiss?()
                }
            }
        }
    }
}
