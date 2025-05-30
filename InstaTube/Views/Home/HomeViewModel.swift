//
//  HomeViewModel.swift
//  InstaTube
//
//  Created by Nassim Morouche on 30/05/2025.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var shorts: [Short] = [.fake1, .fake2, .fake3]
}
