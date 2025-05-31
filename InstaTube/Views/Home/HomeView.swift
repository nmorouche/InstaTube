//
//  ContentView.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI

struct HomeView: View {
    @Bindable var page: Page
    @StateObject var viewModel: HomeViewModel = .init()
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 0) {
                        ForEach($page.shorts) { $short in
                            ShortView(short: $short)
                                .frame(maxWidth: .infinity)
                                .containerRelativeFrame(.vertical)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
                .background(.black.opacity(0.7))
                .ignoresSafeArea()
                
                VStack(alignment: .center) {
                    StoryListView(page: page)
                        .padding(.vertical)
                        .background(.white.opacity(0.8))
                        .clipShape(Capsule())
                    Spacer()
                }
                .padding(.horizontal, 5)
            }
            .task {
                if let page = await viewModel.fetchStories() {
                    self.page.users = page.users
                    self.page.shorts = page.shorts
                    self.page.sortUsersByStoryUnseen()
                }
            }
            .navigationBarHidden(true)
            .navigationTitle("InstaTube")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeView(page: .fake)
}
