//
//  StoryViewModel.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import Foundation

final class StoryViewModel: ObservableObject {
    @Published var tabIndex: Int = 0
    
    init(tabIndex: Int) {
        self.tabIndex = tabIndex
    }
}
