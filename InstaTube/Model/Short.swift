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
        .init(url: "https://blog.codabee.com/wp-content/uploads/2023/12/170272-540p.mp4", liked: false)
    }
    
    static var fake2: Short {
        .init(url: "https://blog.codabee.com/wp-content/uploads/2023/12/170272-540p.mp4", liked: false)
    }
    
    static var fake3: Short {
        .init(url: "https://blog.codabee.com/wp-content/uploads/2023/12/170272-540p.mp4", liked: true)
    }
}
