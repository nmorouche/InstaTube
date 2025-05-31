//
//  SeenResponse.swift
//  InstaTube
//
//  Created by Nassim Morouche on 31/05/2025.
//

struct SeenResponse: Codable {
    var success: Bool
    
    enum CodingKeys: String, CodingKey {
        case success
    }
}
