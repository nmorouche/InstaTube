//
//  Story.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import Foundation

struct Story: Identifiable, Codable {
    var id: Int
    var url: String
    var type: StoryType
    var duration: Double
    var seen: Bool
    var liked: Bool
}

extension Story {
    static var fakeWithImage: Story {
        .init(id: 0, url: "https://plus.unsplash.com/premium_photo-1747054588178-d2e3f110232a?q=80&w=2835&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", type: .image, duration: 5.0, seen: false, liked: false)
    }
    
    static var fakeWithVideo: Story {
        .init(id: 1, url: "https://blog.codabee.com/wp-content/uploads/2023/12/170272-540p.mp4", type: .video, duration: 10.0, seen: false, liked: false)
    }
    
    static var fakeWithSeen: Story {
        .init(id: 2, url: "https://blog.codabee.com/wp-content/uploads/2023/12/170272-540p.mp4", type: .video, duration: 20.0, seen: true, liked: false)
    }
    
    static var fakeWithLike: Story {
        .init(id: 3, url: "https://blog.codabee.com/wp-content/uploads/2023/12/170272-540p.mp4", type: .video, duration: 5.0, seen: true, liked: true)
    }
}
