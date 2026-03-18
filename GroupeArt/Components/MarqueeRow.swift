//
//  MarqueeRow.swift
//  GroupeArt
//
//  Created by FUVE on 17/03/2026.
//

import SwiftUI

struct MarqueeBannerView: View {
    let text: String
    let speed: Double

    private let colors: [Color] = [.orangeArt, .beigeArt, .noirArt, .grisArt]

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<90, id: \.self) { index in
                MarqueeRow(
                    text: text,
                    goesRight: index.isMultiple(of: 2),
                    speed: speed,
                    color: colors[index % colors.count]
                )
            }
        }
    }
}

struct MarqueeRow: View {
    let text: String
    let goesRight: Bool
    let speed: Double
    let color: Color

    @State private var offset: CGFloat = 0

    private let repeatedText: String
    private let unitWidth: CGFloat = 300

    init(text: String, goesRight: Bool, speed: Double, color: Color) {
        self.text = text
        self.goesRight = goesRight
        self.speed = speed
        self.color = color
        self.repeatedText = Array(repeating: text + "   •   ", count: 18).joined()
    }

    var body: some View {
        Text(repeatedText)
            .font(.system(size: 28, weight: .black))
            .foregroundColor(color)
            .fixedSize()
            .offset(x: offset)
            .onAppear {
                offset = goesRight ? -unitWidth : 0
                withAnimation(
                    .linear(duration: speed)
                    .repeatForever(autoreverses: false)
                ) {
                    offset = goesRight ? 0 : -unitWidth
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .clipped()
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        MarqueeBannerView(text: "ABBEY ROAD", speed: 8)
    }
}
