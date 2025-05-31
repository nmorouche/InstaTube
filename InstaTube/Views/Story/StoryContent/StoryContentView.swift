//
//  StoryContentView.swift
//  InstaTube
//
//  Created by Nassim Morouche on 30/05/2025.
//

import SwiftUI
import AVKit

struct StoryContentView: View {
    @Bindable var page: Page
    @Binding var user: User
    @Binding var tabIndex: Int
    @State var player: AVPlayer?
    
    @StateObject var viewModel: StoryContentViewModel
    private var onDismiss: (() -> Void)?

    init(page: Bindable<Page>, user: Binding<User>, tabIndex: Binding<Int>, onDismiss: (() -> Void)? = nil) {
        _page = page
        _user = user
        _tabIndex = tabIndex
        self.onDismiss = onDismiss
        
        _viewModel = StateObject(wrappedValue:StoryContentViewModel(
            currentUserIndex: tabIndex.wrappedValue,
            usersCount: page.users.count,
            storiesCount: user.stories.count)
        )
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    ForEach(0..<user.stories.count, id: \.self) { index in
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
                    CircleImage(imageUrl: user.profilePictureUrl)
                    Text(user.name)
                    Spacer()
                    Button {
                        onDismiss?()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    .tint(.gray)
                }
                Spacer()
            }
            .padding(.top, 50)
            .padding(.horizontal)
            .background(content: {
                StoryMedia(player: $player, story: user.stories[viewModel.currentStory])
                    .ignoresSafeArea()
            })
            .overlay {
                HStack(alignment: .center) {
                    Spacer()
                    VStack(alignment: .trailing,
                           spacing: 32) {
                        Spacer()
                        Button {
                            withAnimation {
                                user.stories[viewModel.currentStory].liked = !user.stories[viewModel.currentStory].liked
                            }
                            
                            Task {
                                let result = await viewModel.likeStory(userId: user.id, storyId: user.stories[viewModel.currentStory].id)
                                if !result {
                                    user.stories[viewModel.currentStory].liked = !user.stories[viewModel.currentStory].liked
                                }
                            }
                        } label: {
                            Image(systemName: user.stories[viewModel.currentStory].liked ? "heart.fill" : "heart")
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
            .onAppear {
                user.stories[viewModel.currentStory].seen = true
                Task {
                    let result = await viewModel.seenStory(userId: user.id, storyId: user.stories[viewModel.currentStory].id)
                    if !result {
                        user.stories[viewModel.currentStory].seen = !user.stories[viewModel.currentStory].seen
                    }
                    page.sortUsersByStoryUnseen()
                }
                
                viewModel.duration = page.users[viewModel.currentUserIndex].stories[viewModel.currentStory].duration
                viewModel.useTimer()
            }
            .onTapGesture { location in
                let point = location.x
                let fullScreen = geo.size.width
                let half = fullScreen / 2
                point > half ? viewModel.nextStory() : viewModel.previousStory()
                user.stories[viewModel.currentStory].seen = true
                Task {
                    let result = await viewModel.seenStory(userId: user.id, storyId: user.stories[viewModel.currentStory].id)
                    if !result {
                        user.stories[viewModel.currentStory].seen = !user.stories[viewModel.currentStory].seen
                    }
                    page.sortUsersByStoryUnseen()
                }
                player?.replaceCurrentItem(with: AVPlayerItem(url: URL(string: user.stories[viewModel.currentStory].url)!))
            }
            .onChange(of: viewModel.shouldTriggerOnNextStory) { oldValue, newValue in
                if !oldValue && newValue {
                    viewModel.shouldTriggerOnNextStory = false
                    withAnimation {
                        if tabIndex < viewModel.usersCount - 1 {
                            tabIndex += 1
                        } else {
                            viewModel.shouldDismiss = true
                        }
                    }
                }
            }
            .onChange(of: viewModel.shouldTriggerOnPreviousStory) { oldValue, newValue in
                if !oldValue && newValue {
                    viewModel.shouldTriggerOnPreviousStory = false
                    withAnimation {
                        if tabIndex > 0 {
                            tabIndex -= 1
                        }
                    }
                }
            }
            .onChange(of: viewModel.shouldDismiss) {
                onDismiss?()
            }
        }
    }
}
