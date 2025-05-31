//
//  StoryService.swift
//  InstaTube
//
//  Created by Nassim Morouche on 31/05/2025.
//

import Foundation
import NetworkService

protocol StoryServiceProtocol {
    func getStories() async -> Result<Page, NetworkError>
}

class StoryService: StoryServiceProtocol {
    
    private let provider = NetworkProvider<StoryAPI>()
    
    func getStories() async -> Result<Page, NetworkError> {
        let result = await provider.load(service: .getStories)
        switch result {
        case .success(let data):
            do {
                let pageData = try JSONDecoder().decode(Page.self, from: data)
                return .success(pageData)
            } catch {
                print("Error decoding the response")
                print("❌ Decoding failed: \(error)")
                return .failure(.generic)
            }

        case .failure(_):
            return .failure(.generic)
        }
    }
}
