//
//  RemoteImage.swift
//  InstaTube
//
//  Created by Nassim Morouche on 29/05/2025.
//

import SwiftUI
import Kingfisher

struct RemoteImage: View {
    
    let imageUrl: String
    var size: CGSize?
    var fallbackImage = AnyView(Self.noImage)
    
    var body: some View {
        if let url = URL(string: imageUrl) {
            KFImage(url)
                .setProcessors(processors)
                .resizable()
                .cancelOnDisappear(true)
                .onFailure { [] error in
                    print("❌ KingFisher - Error parsing the image: \n\(error)")
                }
                .placeholder {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: size?.width, height: size?.height)
        } else {
            fallbackImage
        }
    }
}

extension RemoteImage {
    static var noImage: some View {
        Color.gray
            .overlay(
                Image(systemName: "photo.on.rectangle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .scaleEffect(0.3)
                    .opacity(0.8)
                    .padding(.horizontal)
            )
    }

    static var fakeImage: some View {
        LinearGradient(gradient: Gradient(colors: [.orange, .pink]), startPoint: .top, endPoint: .bottom)
            .overlay(
                Image(systemName: "photo.on.rectangle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .scaleEffect(0.5)
                    .opacity(0.8)
            )
    }
}

private extension RemoteImage {
    var processors: [ImageProcessor] {
        if let size = size {
            let scale = UIScreen.main.scale
            let proc = DownsamplingImageProcessor(size: CGSize(width: size.width * scale, height: size.height * scale))
            return [proc]
        }
        return []
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static let imageUrl: String = "https://images.pexels.com/photos/32212380/pexels-photo-32212380.jpeg"
    static let size: CGSize = .init(width: 200, height: 200)
    
    static var previews: some View {
        VStack {
            RemoteImage(imageUrl: imageUrl, size: size)
                .frame(width: size.width, height: size.height)
            
        }
    }
}
