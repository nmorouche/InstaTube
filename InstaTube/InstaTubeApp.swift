//
//  InstaTubeApp.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI
import Injector

@main
struct InstaTubeApp: App {
    @State private var page: Page = .fake

    init() {
        Locator.register(StoryServiceProtocol.self, mode: .newInstance) { StoryService() }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(page: page)
        }
        .environment(page)
    }
}
