//
//  Short.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import Foundation

struct Short: Identifiable {
    var id = UUID()
    var url: String
    var liked: Bool
}

extension Short {
    static var fake1: Short {
        .init(url: "https://blog.codabee.com/wp-content/uploads/2023/12/waterfall_-_115537-720p.mp4", liked: false)
    }
    
    static var fake2: Short {
        .init(url: "https://blog.codabee.com/wp-content/uploads/2023/12/170617-1080p.mp4", liked: false)
    }
    
    static var fake3: Short {
        .init(url: "https://blog.codabee.com/wp-content/uploads/2023/12/159703-720p.mp4", liked: true)
    }
}
