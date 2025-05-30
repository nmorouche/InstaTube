//
//  StoryView.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI

struct StoryView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var storyListViewModel: StoryListViewModel
    @StateObject var viewModel: StoryViewModel

    init(tabIndex: Int) {
        _viewModel = StateObject(wrappedValue: StoryViewModel(tabIndex: tabIndex))
    }
        
    var body: some View {
        TabView(selection: $viewModel.tabIndex,
                content:  {
            ForEach(0..<storyListViewModel.users.count, id: \.self) { currentUserIndex in
                GeometryReader { geometry in
                    StoryContentView(currentUserIndex: currentUserIndex, users: $storyListViewModel.users, tabIndex: $viewModel.tabIndex, onNext: {
                        withAnimation {
                            viewModel.tabIndex += 1
                        }
                    }, onPrevious: {
                        if viewModel.tabIndex != 0 {
                            withAnimation {
                                viewModel.tabIndex -= 1
                            }
                        }
                    }, onDismiss: {
                        withAnimation {
                            dismiss()
                        }
                    })
                    .tag(currentUserIndex)
                    .rotation3DEffect(
                        angle(geometry: geometry),
                        axis: (x: 0.0, y: 1.0, z: 0.0),
                        anchor: geometry.frame(in: .global).minX > 0 ? .leading : .trailing,
                        perspective: 2
                    )
                }
            }
        })
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .transition(.move(edge: .bottom))
        .toolbar(.hidden)
    }
    
    func angle(geometry: GeometryProxy) -> Angle {
        let minX = geometry.frame(in: .global).minX
        let globalSize = geometry.size.width
        let rotationProgression = minX / globalSize
        let degree = rotationProgression * 45
        return Angle(degrees: degree)
    }
}

#Preview {
    StoryView(tabIndex: 2)
        .environmentObject(StoryListViewModel(users: [.fake1, .fake2, .fake3]))
}
