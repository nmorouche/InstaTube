//
//  InstaTubeApp.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI

@main
struct InstaTubeApp: App {
    @State private var page: Page = .fake

    var body: some Scene {
        WindowGroup {
            HomeView(page: page)
        }
        .environment(page)
    }
}
