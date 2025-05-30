//
//  Page.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import Foundation

struct Page: Identifiable {
    var id = UUID()
    var users: [User]
}

extension Page {
    static var fake: Page {
        .init(users: [
            .fake1,
            .fake2,
            .fake3,
            .fake4,
        ])
    }
}
