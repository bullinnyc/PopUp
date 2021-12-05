//
//  Extension + AnyTransition.swift
//  PopUp
//
//  Created by Dmitry Kononchuk on 05.12.2021.
//

import SwiftUI

extension AnyTransition {
    static func popUp() -> AnyTransition {
        let insertion = AnyTransition.opacity
            .combined(with: .scale)
            .animation(.spring().speed(1.5))
        
        let removal = AnyTransition.opacity
            .animation(.easeOut(duration: 0.21))
        
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
