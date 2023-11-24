//
//  AppTextFieldStile.swift
//  QRCodeSwiftUI
//
//  Created by Ульяна Гритчина on 24.11.2023.
//

import SwiftUI

struct AppTextFieldStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(
                size: 20,
                weight: .regular, design: .rounded
            ))
            .padding(10)
            .background(.gray.opacity(0.2))
            .cornerRadius(8)
            .frame(maxWidth: 700)
    }
}

extension View {
    func appTextFieldStyle() -> some View {
        modifier(AppTextFieldStyle())
    }
}
