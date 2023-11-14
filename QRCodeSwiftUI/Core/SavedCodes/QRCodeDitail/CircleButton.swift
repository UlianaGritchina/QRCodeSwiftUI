//
//  CircleButton.swift
//  QRCodeSwiftUI
//
//  Created by Ульяна Гритчина on 14.11.2023.
//

import SwiftUI

struct CircleButton: View {
    let imageName: String
    let action: () -> ()
    var body: some View {
        Button(action: {}, label: {
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(Color("cardBackground"))
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 0)
                .overlay {
                    Image(systemName: imageName)
                }
        })
        .padding()
    }
}

#Preview {
    CircleButton(imageName: "trash", action: { })
}
