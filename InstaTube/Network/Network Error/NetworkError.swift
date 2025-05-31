//
//  NetworkError.swift
//  InstaTube
//
//  Created by Nassim Morouche on 31/05/2025.
//

import Foundation

enum NetworkError: Error {
    case generic
    
    init() {
        self = .generic
    }
    
    init(error: Error) {
        self = .generic
    }
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .generic:
            return NSLocalizedString("Generic error", comment: "Network Generic Error")
        }
    }
}
