//
//  User.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import Foundation

@Observable
final class User: Identifiable, Codable {
    var id: Int
    var name: String
    var profilePictureUrl: String
    var stories: [Story]
    
    enum CodingKeys: String, CodingKey {
        case id, name, stories
        case profilePictureUrl = "profile_picture_url"
    }
    
    init(id: Int, name: String, profilePictureUrl: String, stories: [Story]) {
        self.id = id
        self.name = name
        self.profilePictureUrl = profilePictureUrl
        self.stories = stories
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let profilePictureURL = try container.decode(String.self, forKey: .profilePictureUrl)
        let stories = try container.decode([Story].self, forKey: .stories)

        self.init(id: id, name: name, profilePictureUrl: profilePictureURL, stories: stories)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(profilePictureUrl, forKey: .profilePictureUrl)
        try container.encode(stories, forKey: .stories)
    }
    
    var isStoryUnseen: Bool {
        stories.contains(where: { !$0.seen })
    }
}

extension User: Hashable, Equatable {
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

extension User {
    static var fake1: User {
        .init(id: 0, name: "Test", profilePictureUrl: "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", stories: [.fakeWithImage, .fakeWithVideo])
    }
    
    static var fake2: User {
        .init(id: 1, name: "Test", profilePictureUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", stories: [.fakeWithVideo])
    }
    
    static var fake3: User {
        .init(id: 2, name: "Test", profilePictureUrl: "https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?q=80&w=2000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", stories: [.fakeWithSeen, .fakeWithVideo])
    }
    
    static var fake4: User {
        .init(id: 3, name: "Test", profilePictureUrl: "https://images.unsplash.com/photo-1534308143481-c55f00be8bd7?q=80&w=2830&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", stories: [.fakeWithLike])
    }
}
