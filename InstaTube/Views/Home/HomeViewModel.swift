//
//  HomeViewModel.swift
//  InstaTube
//
//  Created by Nassim Morouche on 31/05/2025.
//

import Foundation
import Injector

final class HomeViewModel: ObservableObject {
    @Published var tabIndex: Int = 0
    @Published var hasError = false
    @Published var isLoading = false
    @Published var error: NetworkError? {
        didSet {
            hasError = true
        }
    }
    
    @Inject var storyService: StoryServiceProtocol
    
    @MainActor
    func fetchStories() async -> Page? {
        isLoading = true
        
        let result = await storyService.getStories()
        isLoading = true
        switch result {
        case .success(let page):
            return page
        case .failure(let error):
            self.error = error
        }
        
        return nil
    }
}
