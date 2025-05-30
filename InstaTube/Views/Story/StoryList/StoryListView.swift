//
//  StoryListView.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI

struct StoryListView: View {
    
    @StateObject private var viewModel: StoryListViewModel = .init(users:
                                                                    [.fake1, .fake2, .fake3, .fake4]
        .sorted(by: { $0.isStoryUnseen && !$1.isStoryUnseen })
    )
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<viewModel.users.count, id: \.self) { userIndex in
                    NavigationLink {
                        StoryView(tabIndex: userIndex)
                            .environmentObject(viewModel)
                    } label: {
                        CircleImage(imageUrl: viewModel.users[userIndex].profilePictureUrl,
                                    unseen: viewModel.users[userIndex].isStoryUnseen)
                    }
                    .padding(.trailing, 5)
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    StoryListView()
}
