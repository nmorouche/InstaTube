//
//  ShortService.swift
//  InstaTube
//
//  Created by Nassim Morouche on 31/05/2025.
//

import Foundation
import NetworkService

protocol ShortServiceProtocol {
    func likeShort(shortId: Int) async -> Result<Bool, NetworkError>
}

class ShortService: ShortServiceProtocol {
    
    private let provider = NetworkProvider<ShortAPI>()
    
    func likeShort(shortId: Int) async -> Result<Bool, NetworkError> {
        let result = await provider.load(service: .like(shortId: shortId))
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
}
