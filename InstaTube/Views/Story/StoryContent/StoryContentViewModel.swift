//
//  StoryContentViewModel.swift
//  InstaTube
//
//  Created by Nassim Morouche on 30/05/2025.
//

import Foundation

final class StoryContentViewModel: ObservableObject {
    var currentUserIndex: Int
    var usersCount: Int = 0
    var storiesCount: Int = 0
    @Published var currentStory: Int = 0
    @Published var timer: Timer?
    @Published var progress: CGFloat = 0
    @Published var timeSpent: CGFloat = 0
    @Published var duration: CGFloat = 0
    @Published var shouldTriggerOnNextAction: Bool = false
    @Published var shouldTriggerOnPreviousAction: Bool = false
    @Published var shouldDismiss: Bool = false
    
    init(currentUserIndex: Int) {
        self.currentUserIndex = currentUserIndex
    }
    
    func useTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            timeSpent += 0.1
            progress = timeSpent / duration
            if (timeSpent >= duration) {
                nextStory()
            }
        })
    }
    
    func nextStory() {
        progress = 0
        timeSpent = 0
        timer?.invalidate()
        if currentStory < storiesCount - 1 {
            currentStory += 1
            useTimer()
        } else if currentUserIndex < usersCount - 1 {
            shouldTriggerOnNextAction = true
        } else {
            shouldDismiss = true
        }
    }
    
    func previousStory() {
        progress = 0
        timeSpent = 0
        timer?.invalidate()
        if currentStory > 0 {
            currentStory -= 1
            useTimer()
        } else if currentUserIndex > 0 {
            shouldTriggerOnPreviousAction = true
        } else {
            currentStory = 0
            useTimer()
        }
    }
}
