//
//  ViewOffsetPreferenceKey.swift
//  InstaTube
//
//  Created by Nassim Morouche on 31/05/2025.
//

import SwiftUI

struct ViewOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGRect
    static var defaultValue: CGRect = CGRect.zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
