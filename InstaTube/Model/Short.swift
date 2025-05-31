//
//  Short.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import Foundation

struct Short: Identifiable, Codable, Hashable {
    var id: Int
    var url: String
    var liked: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, liked
        case url = "media_url"
    }
}

extension Short {
    static var fake1: Short {
        .init(id: 0, url: "https://blog.codabee.com/wp-content/uploads/2023/12/170272-540p.mp4", liked: false)
    }
    
    static var fake2: Short {
        .init(id: 1, url: "https://blog.codabee.com/wp-content/uploads/2023/12/170272-540p.mp4", liked: false)
    }
    
    static var fake3: Short {
        .init(id: 2, url: "https://blog.codabee.com/wp-content/uploads/2023/12/170272-540p.mp4", liked: true)
    }
}
