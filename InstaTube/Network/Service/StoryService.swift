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
    func likeStory(userId: Int, storyId: Int) async -> Result<Bool, NetworkError>
    func seenStory(userId: Int, storyId: Int) async -> Result<Bool, NetworkError>
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
                print("❌ Decoding failed: \(error)")
                return .failure(.generic)
            }

        case .failure(_):
            return .failure(.generic)
        }
    }
    
    func likeStory(userId: Int, storyId: Int) async -> Result<Bool, NetworkError> {
        let result = await provider.load(service: .like(userId: userId, storyId: storyId))
        switch result {
        case .success(let data):
            do {
                let likeResponse = try JSONDecoder().decode(LikeResponse.self, from: data)
                return .success(likeResponse.success)
            } catch {
                print("❌ Decoding failed: \(error)")
                return .failure(.generic)
            }

        case .failure(_):
            return .failure(.generic)
        }
    }
    
    func seenStory(userId: Int, storyId: Int) async -> Result<Bool, NetworkError> {
        let result = await provider.load(service: .seen(userId: userId, storyId: storyId))
        switch result {
        case .success(let data):
            do {
                let seenResponse = try JSONDecoder().decode(SeenResponse.self, from: data)
                return .success(seenResponse.success)
            } catch {
                print("❌ Decoding failed: \(error)")
                return .failure(.generic)
            }

        case .failure(_):
            return .failure(.generic)
        }
    }
}
