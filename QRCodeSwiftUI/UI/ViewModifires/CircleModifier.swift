//
//  CircleModifier.swift
//  QRCodeSwiftUI
//
//  Created by Ульяна Гритчина on 20.01.2024.
//

import SwiftUI

struct CircleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 50, height: 50)
            .background(Color("cardBackground"))
            .clipShape(.circle)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 0)
    }
}

extension View {
    func circleModifier() -> some View {
        modifier(CircleModifier())
    }
}
