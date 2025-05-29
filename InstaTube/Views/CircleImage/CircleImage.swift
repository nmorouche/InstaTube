//
//  CircleImage.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI

struct CircleImage: View {
    var imageUrl: String
    var size: CGSize = .init(width: 50, height: 50)
    var unseen: Bool = false
    
    var body: some View {
        ZStack {
            RemoteImage(imageUrl: imageUrl, size: size)
                .frame(width: size.width, height: size.height)
                .background(.secondary)
                .clipShape(Circle())
            
            Circle()
                .strokeBorder(
                    unseen ? Color.red : Color.clear,
                )
        }
        .frame(width: size.width, height: size.height)
    }
}

#Preview {
    CircleImage(imageUrl: "https://images.pexels.com/photos/32212380/pexels-photo-32212380.jpeg")
}
