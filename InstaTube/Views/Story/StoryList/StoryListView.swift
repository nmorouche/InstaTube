//
//  StoryListView.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI

struct StoryListView: View {
    @Bindable var page: Page
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach($page.users) { $user in
                    NavigationLink {
                        StoryView(page: $page, user: $user, tabIndex: page.users.firstIndex(of: user) ?? 0)
                            .ignoresSafeArea()
                    } label: {
                        CircleImage(imageUrl: user.profilePictureUrl,
                                    unseen: user.isStoryUnseen)
                    }
                    .padding(.trailing, 5)
                }
            }
            .padding(.horizontal, 10)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    StoryListView(page: .fake)
}
