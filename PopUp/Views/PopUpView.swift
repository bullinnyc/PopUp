//
//  PopUpView.swift
//  PopUp
//
//  Created by Dmitry Kononchuk on 16.09.2021.
//  Copyright © 2021 Dmitry Kononchuk. All rights reserved.
//

import SwiftUI

struct PopUpView: View {
    // MARK: - Property Wrappers
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var isShowPopUp = false
    @State private var questionMidX: CGFloat = 0
    @State private var timer: Timer?
    
    // MARK: - Public Properties
    let title: String
    let color: Color
    let width: CGFloat
    let height: CGFloat
    let questionImageSize: CGFloat
    let completion: () -> String
    
    // MARK: - Initializers
    init(title: String, color: Color, width: CGFloat, height: CGFloat, questionImageSize: CGFloat = 20, completion: @escaping () -> String
    ) {
        self.title = title
        self.color = color
        self.width = width
        self.height = height
        self.questionImageSize = questionImageSize
        self.completion = completion
    }
    
    // MARK: - body Property
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                if isShowPopUp {
                    let triangleSize = geometry.size.height * 0.13
                    
                    ZStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                            
                            Triangle()
                                .rotationEffect(.degrees(180))
                                .frame(width: triangleSize, height: triangleSize)
                                .position(
                                    x: questionMidX,
                                    y: geometry.size.height + triangleSize * 0.5
                                )
                        }
                        .opacity(0.9)
                        .foregroundColor(color)
                        .compositingGroup()
                        .shadow(color: .black.opacity(0.4), radius: 10, x: 2, y: 4)
                        
                        Text(completion())
                            .font(.callout)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(.darkText))
                            .padding()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    .transition(.popUp())
                    .position(
                        x: geometry.size.width * 0.5,
                        y: -triangleSize - questionImageSize * 0.7
                    )
                }
                
                HStack(spacing: 10) {
                    Text(title)
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .foregroundColor(
                            colorScheme == .light ? .black : .white
                        )
                    
                    GeometryReader { questionmarkGeo in
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .foregroundColor(
                                colorScheme == .light ? Color(.systemBlue) : Color(.white).opacity(0.8)
                            )
                            .background(colorScheme == .light ? Color.white : Color.black)
                            .clipShape(Circle())
                            .overlay(Circle()
                                        .stroke(
                                            colorScheme == .light
                                            ? Color.white.opacity(0.8)
                                            : Color.black.opacity(0.8), lineWidth: 1
                                        )
                            )
                            .opacity(0.8)
                            .preference(
                                key: CoordinatePreferenceKey.self,
                                value: questionmarkGeo.frame(in: .named("questionMidX")).midX
                            )
                            .onTapGesture {
                                isShowPopUp.toggle()
                                timerPopUp()
                            }
                    }
                    .frame(width: questionImageSize, height: questionImageSize)
                }
                .onPreferenceChange(CoordinatePreferenceKey.self) { coordinate in
                    questionMidX = coordinate
                }
                .position(
                    x: geometry.size.width * 0.5,
                    y: geometry.size.height * 0.5
                )
            }
            .frame(width: width, height: height)
        }
        .frame(width: width, height: questionImageSize)
        .coordinateSpace(name: "questionMidX")
    }
    
    // MARK: - Private Methods
    private func timerPopUp() {
        if let runningTimer = timer {
            runningTimer.invalidate()
            timer = nil
        }
        
        if isShowPopUp {
            timer = Timer.scheduledTimer(withTimeInterval: 8, repeats: false) { _ in
                isShowPopUp.toggle()
            }
        }
    }
}

// MARK: - Preview Provider
@available(iOS 15.0, *)
struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()
            
            PopUpView(title: "Title text", color: .white, width: 300, height: 100) {
                "Some text"
            }
        }
        .environment(\.colorScheme, .light)
        .previewInterfaceOrientation(.portrait)
    }
}
