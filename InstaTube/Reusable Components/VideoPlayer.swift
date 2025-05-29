//
//  VideoPlayer.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI
import AVKit

struct VideoPlayer: UIViewControllerRepresentable {
    @Binding var avPlayer: AVPlayer?
    
    func makeUIViewController(context: Context) ->  AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = avPlayer
        controller.videoGravity = .resizeAspectFill
        controller.showsPlaybackControls = false
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = avPlayer
    }
    
}
