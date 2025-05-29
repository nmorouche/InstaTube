//
//  StoryView.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI

struct StoryView: View {
    @Environment(\.dismiss) var dismiss
    var onSeen: ((Int) -> Void)?
    var onLike: ((Int) -> Void)?
    
    @StateObject var viewModel: StoryViewModel

    init(pageIndex: Int, userIndex: Int, pages: [Page], onSeen: ((Int) -> Void)?, onLike: ((Int) -> Void)?) {
        _viewModel = StateObject(wrappedValue: StoryViewModel(pages: pages, pageIndex: pageIndex, userIndex: userIndex))
        self.onSeen = onSeen
        self.onLike = onLike
    }
        
    var body: some View {
        TabView(selection: $viewModel.index,
                content:  {
            ForEach(0..<viewModel.pages[viewModel.pageIndex].users.count, id: \.self) { currentUserIndex in
                GeometryReader { geometry in
                    fullScreenStory
                        .onTapGesture { location in
                            let point = location.x
                            let fullScreen = geometry.size.width
                            let half = fullScreen / 2
                            (point > half) ? viewModel.nextStory() : viewModel.previousStory()
                        }
                        .tag(currentUserIndex)
                }
            }
        })
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .transition(.move(edge: .bottom))
        .toolbar(.hidden)
    }
    
    var fullScreenStory: some View {
        VStack {
            HStack {
                ForEach(0..<viewModel.currentUser.stories.count, id: \.self) { index in
                    if (index < viewModel.currentStoryIndex) {
                        ProgressView(value: 1)
                    } else if (index > viewModel.currentStoryIndex) {
                        ProgressView(value: 0)
                    } else {
                        ProgressView(value: viewModel.progress)
                    }
                }
            }
            HStack(alignment: .center) {
                CircleImage(imageUrl: viewModel.currentUser.profilePictureUrl)
                Text(viewModel.currentUser.name)
                Spacer()
                Button("", systemImage: "xmark") {
                    dismiss()
                }
                .tint(.gray)
            }
            Spacer()
        }
        .overlay {
            fullScreenStoryOverlay
        }
        .padding()
        .background(content: {
            StoryDisplay(story: viewModel.currentStory)
        })
        .onAppear() {
            onSeen?(viewModel.currentStoryIndex)
            viewModel.duration = viewModel.currentStory.duration
            viewModel.storyTimer()
        }
        .onChange(of: viewModel.shouldDismiss) {
            dismiss()
        }
    }
    
    var fullScreenStoryOverlay: some View {
        HStack(alignment: .bottom) {
            Spacer()
            VStack(alignment: .trailing,
                   spacing: 32) {
                Spacer()
                Button("", systemImage: viewModel.currentStory.liked ? "heart.fill" : "heart", action: {
                    onLike?(viewModel.currentStoryIndex)
                })
                .tint(viewModel.currentStory.liked ? .red : .black)
                Button("", systemImage: "message", action: {})
                Button("", systemImage: "paperplane", action: {})
                Button("", systemImage: "list.bullet", action: {})
            }.tint(.black)
                .font(.title)
        }
    }
}

#Preview {
    StoryView(pageIndex: 0, userIndex: 0, pages: [.fake], onSeen: nil, onLike: nil)
}
