//
//  StoryAPI.swift
//  InstaTube
//
//  Created by Nassim Morouche on 31/05/2025.
//

import Foundation
import NetworkService

enum StoryAPI {
    case getStories
    case like(userId: Int, storyId: Int)
    case seen(userId: Int, storyId: Int)
}

extension StoryAPI: Service {
    var baseURL: String {
        "http://localhost:3000/story/"
    }
    
    var path: String {
        switch self {
        case .getStories:
            return "all"
        case .like(let userId, let storyId):
            return "like/\(userId)/\(storyId)"
        case .seen(let userId, let storyId):
            return "seen/\(userId)/\(storyId)"
        }
    }
    
    var method: ServiceMethod {
        switch self {
        case .getStories:
            return .get
        case .like(_, _),
                .seen(_, _):
            return .patch
        }
    }
    
    var parameters: [String : String]? {
        nil
    }
    
    var body: Data? {
        nil
    }
}
