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
    var users: [User]
    var shorts: [Short]
    
    enum CodingKeys: String, CodingKey {
        case users
        case shorts
    }
    
    init(users: [User] = [], shorts: [Short] = []) {
        self.users = users
        self.shorts = shorts
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let users = try container.decode([User].self, forKey: .users)
        let shorts = try container.decode([Short].self, forKey: .shorts)
        self.init(users: users, shorts: shorts)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(users, forKey: .users)
        try container.encode(shorts, forKey: .shorts)
    }
    
    func sortUsersByStoryUnseen() {
        users.sort(by: { $0.isStoryUnseen && !$1.isStoryUnseen })
    }
}

extension Page {
    static var fake: Page {
        .init(users: [.fake1, .fake2, .fake3, .fake4],
              shorts: [.fake1, .fake2, .fake3]
        )
    }
}
