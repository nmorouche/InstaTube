//
//  StoryView.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI

struct StoryView: View {
    @Bindable var page: Page
    @Binding var user: User
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: StoryViewModel

    init(page: Bindable<Page>, user: Binding<User>, tabIndex: Int) {
        _page = page
        _user = user
        _viewModel = StateObject(wrappedValue: StoryViewModel(tabIndex: tabIndex))
    }
        
    var body: some View {
        TabView(selection: $viewModel.tabIndex,
                content:  {
            ForEach($page.users) { $user in
                GeometryReader { geometry in
                    StoryContentView(
                        page: $page,
                        user: $user,
                        tabIndex: $viewModel.tabIndex,
                        onDismiss: {
                            withAnimation {
                                dismiss()
                            }
                        }
                    )
                    .cornerRadius(50)
                    .tag(user.id)
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
        .transition(.move(edge: .trailing))
        .toolbar(.hidden)
        .statusBarHidden()
        .ignoresSafeArea()
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
    @Previewable
    @Bindable var page: Page = .fake
    StoryView(page: _page, user: .constant(.fake1), tabIndex: 2)
}
