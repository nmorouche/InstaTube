//
//  Page.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import Foundation

@Observable
final class Page: Identifiable, Codable {
    var id = UUID()
    var users: [User] = []
    var shorts: [Short] = []
    
    init(users: [User] = [], shorts: [Short] = []) {
        self.users = users
        self.shorts = shorts
    }
}

extension Page {
    static var fake: Page {
        .init(users: [.fake1, .fake2, .fake3, .fake4],
              shorts: [.fake1, .fake2, .fake3]
        )
    }
}
