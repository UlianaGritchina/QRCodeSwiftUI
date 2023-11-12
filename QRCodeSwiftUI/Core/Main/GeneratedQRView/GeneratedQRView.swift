//
//  QRCodeView.swift
//  QRCodeSwiftUI
//
//  Created by Ульяна Гритчина on 12.11.2023.
//

import SwiftUI

struct GeneratedQRView: View {
    let qrCodeImageData: Data?
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                VStack {
                    qrCode
                    Spacer()
                    ButtonView(title: "Save", action: { })
                }
                .padding()
            }
            .navigationTitle("Generated")
        }
    }
}

#Preview {
    GeneratedQRView(
        qrCodeImageData: UIImage(named: "defaultQRImage")?.pngData()
    )
}

extension GeneratedQRView {
    
    @ViewBuilder private var qrCode: some View {
        if let qrCodeImageData {
            QrView(data: qrCodeImageData, size: 300)
        }
    }
    
}
