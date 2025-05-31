//
//  ShortAPI.swift
//  InstaTube
//
//  Created by Nassim Morouche on 31/05/2025.
//

import Foundation
import NetworkService

enum ShortAPI {
    case like(shortId: Int)
}

extension ShortAPI: Service {
    var baseURL: String {
        "http://localhost:3000/short/"
    }
    
    var path: String {
        switch self {
        case .like(let shortId):
            return "like/\(shortId)"
        }
    }
    
    var method: ServiceMethod {
        switch self {
        case .like:
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
