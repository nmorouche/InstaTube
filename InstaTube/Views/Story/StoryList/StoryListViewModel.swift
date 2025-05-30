//
//  StoryListViewModel.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import Foundation

final class StoryListViewModel: ObservableObject {
    @Published var users: [User]
    
    init(users: [User]) {
        self.users = users
    }
}
