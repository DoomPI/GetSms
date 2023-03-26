//
//  ShimmerEffect.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func shimmer(
        tint: Color,
        highlight: Color,
        blur: CGFloat = 0,
        highlightOpacity: CGFloat = 1,
        speed: CGFloat = 2
    ) -> some View {
        self.modifier(ShimmerEffect(
            tint: tint,
            highlight: highlight,
            blur: blur,
            highlightOpacity: highlightOpacity,
            speed: speed
        ))
    }
}

fileprivate struct ShimmerEffect: ViewModifier {
    
    var tint: Color
    var highlight: Color
    var blur: CGFloat
    var highlightOpacity: CGFloat
    var speed: CGFloat
    
    @State private var moveTo: CGFloat = -0.7
    
    func body(content: Content) -> some View {
        content
            .hidden()
            .overlay {
                Rectangle()
                    .fill(tint)
                    .mask {
                        content
                    }
                    .overlay {
                        GeometryReader {
                            let size = $0.size
                            
                            Rectangle()
                                .fill(highlight)
                                .mask {
                                    Rectangle()
                                        .fill(.linearGradient(
                                            colors: [
                                                .white.opacity(0),
                                                highlight.opacity(
                                                    highlightOpacity
                                                ),
                                                .white.opacity(0)
                                            ],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        ))
                                        .blur(radius: blur)
                                        .rotationEffect(.init(degrees: -70))
                                        .offset(x: size.width * moveTo)
                                }
                        }
                        .mask {
                            content
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.async {
                            moveTo = 0.7
                        }
                    }
                    .animation(
                        .linear(duration: speed)
                        .repeatForever(autoreverses: false),
                        value: moveTo
                    )
            }
    }
}

struct ShimmerConfig {
    var tint: Color
    var highlight: Color
    var blur: CGFloat = 0
    var highlighOpacity: CGFloat = 1
    var speed: CGFloat = 2
}
