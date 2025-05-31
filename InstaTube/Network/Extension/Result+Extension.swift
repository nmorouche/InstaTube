//
//  Result+Extension.swift
//  InstaTube
//
//  Created by Nassim Morouche on 31/05/2025.
//

import Foundation

extension Result {
    var isSuccess: Bool { if case .success = self { return true } else { return false } }

    var isError: Bool { return !isSuccess }

    var error: Error? { if case .failure(let error) = self { return error } else { return nil } }
}
