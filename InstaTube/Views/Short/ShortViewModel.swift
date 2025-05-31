//
//  ShortViewModel.swift
//  InstaTube
//
//  Created by Nassim Morouche on 31/05/2025.
//

import Foundation
import Injector

final class ShortViewModel: ObservableObject {
    @Inject var shortService: ShortServiceProtocol

    @MainActor
    func likeShort(shortId: Int) async -> Bool {
        let result = await shortService.likeShort(shortId: shortId)
        switch result {
        case .success(let success):
            return success
        case .failure(let error):
            print("Error liking story: \n\(error.localizedDescription)")
        }
        
        return false
    }
}
