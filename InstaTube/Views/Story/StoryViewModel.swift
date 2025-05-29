//
//  StoryViewModel.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import Foundation

final class StoryViewModel: ObservableObject {
    @Published var index: Int = 0
    @Published var currentStoryIndex: Int = 0
    @Published var pages: [Page]
    @Published var pageIndex: Int
    @Published var userIndex: Int
    @Published var timer: Timer?
    @Published var progress: CGFloat = 0
    @Published var timeSpent: CGFloat = 0
    @Published var duration: CGFloat = 0
    @Published var shouldDismiss: Bool = false
    
    var currentUser: User {
        pages[pageIndex].users[userIndex]
    }
    
    var currentStory: Story {
        pages[pageIndex].users[userIndex].stories[currentStoryIndex]
    }
    
    init(pages: [Page], pageIndex: Int, userIndex: Int) {
        self.pages = pages
        self.pageIndex = pageIndex
        self.userIndex = userIndex
    }
    
    func storyTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            self.timeSpent += 0.1
            self.progress = self.timeSpent / self.duration
            if (self.timeSpent >= self.duration) {
                self.nextStory()
            }
        })
    }
    
    func nextStory() {
        progress = 0
        timeSpent = 0
        timer?.invalidate()
        if currentStoryIndex < currentUser.stories.count - 1 {
            currentStoryIndex += 1
            storyTimer()
        } else if userIndex < pages[pageIndex].users.count - 1 {
            // GO NEXT USER
        } else {
            shouldDismiss = true
        }
    }
    
    func previousStory() {
        progress = 0
        timeSpent = 0
        timer?.invalidate()
        if currentStoryIndex > 0 {
            currentStoryIndex -= 1
            storyTimer()
        } else if userIndex > 0 {
            // GO PREVIOUS USER
        } else {
            currentStoryIndex = 0
            storyTimer()
        }
    }
}
