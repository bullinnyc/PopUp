//
//  ContentView.swift
//  PopUp
//
//  Created by Dmitry Kononchuk on 16.09.2021.
//  Copyright © 2021 Dmitry Kononchuk. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // MARK: - body Property
    var body: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()
            
            PopUpView(
                title: "Quote",
                color: .white,
                width: 300,
                height: 100) {
                    "Life is like a box of chocolates, you never know what you’re gonna get."
                }
        }
    }
}

// MARK: - Preview Provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
