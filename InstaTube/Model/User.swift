//
//  User.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import Foundation

struct User: Identifiable {
    var id = UUID()
    var name: String
    var profilePictureUrl: String
    var stories: [Story]
}

extension User {
    static var fake1: User {
        .init(name: "Test", profilePictureUrl: "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", stories: [.fakeWithImage, .fakeWithVideo])
    }
    
    static var fake2: User {
        .init(name: "Test", profilePictureUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", stories: [.fakeWithVideo])
    }
    
    static var fake3: User {
        .init(name: "Test", profilePictureUrl: "https://images.unsplash.com/photo-1457449940276-e8deed18bfff?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", stories: [])
    }
    
    static var fake4: User {
        .init(name: "Test", profilePictureUrl: "https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?q=80&w=2000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", stories: [.fakeWithSeen, .fakeWithVideo])
    }
    
    static var fake5: User {
        .init(name: "Test", profilePictureUrl: "https://images.unsplash.com/photo-1534308143481-c55f00be8bd7?q=80&w=2830&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", stories: [.fakeWithLike])
    }
}
