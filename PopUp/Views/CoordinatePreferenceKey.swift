//
//  CoordinatePreferenceKey.swift
//  PopUp
//
//  Created by Dmitry Kononchuk on 05.12.2021.
//

import SwiftUI

struct CoordinatePreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}
