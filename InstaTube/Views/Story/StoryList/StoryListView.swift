//
//  StoryListView.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI

struct StoryListView: View {
    
    @StateObject private var viewModel: StoryListViewModel = .init(pages: [.fake])
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<viewModel.pages.count, id: \.self) { pageIndex in
                    ForEach(0..<viewModel.pages[pageIndex].users.count, id: \.self) { userIndex in
                        if !viewModel.pages[pageIndex].users[userIndex].stories.isEmpty {
                            NavigationLink {
                                StoryView(pageIndex: pageIndex,
                                          userIndex: userIndex,
                                          pages: viewModel.pages,
                                          onSeen: { storyIndex in
                                    viewModel.pages[pageIndex].users[userIndex].stories[storyIndex].seen = true
                                },
                                          onLike: { storyIndex in
                                    viewModel.pages[pageIndex].users[userIndex].stories[storyIndex].liked = !viewModel.pages[pageIndex].users[userIndex].stories[storyIndex].liked
                                }
                                )
                            } label: {
                                CircleImage(
                                    imageUrl: viewModel.pages[pageIndex].users[userIndex].profilePictureUrl,
                                    unseen: viewModel.pages[pageIndex].users[userIndex].stories.contains(where: { !$0.seen })
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    StoryListView()
}
