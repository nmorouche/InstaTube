//
//  ContentView.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        let shorts: [Short] = [.fake1, .fake2, .fake3]
        NavigationStack {
            VStack {
                StoryListView()
                Divider()
                ScrollView(.vertical) {
                    LazyVStack(spacing: 0) {
                        ForEach(shorts) { short in
                            ShortView(short: short)
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
    HomeView()
}
