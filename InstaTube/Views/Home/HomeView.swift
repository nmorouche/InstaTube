//
//  ContentView.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI

struct HomeView: View {
    @Bindable var page: Page
    
    var body: some View {
        NavigationStack {
            VStack {
                StoryListView(page: page)
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
                .background(.black)
                .ignoresSafeArea()
            }
            .navigationTitle("InstaTube")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeView(page: .fake)
}
