//
//  QRCodeView.swift
//  QRCodeSwiftUI
//
//  Created by Ульяна Гритчина on 12.11.2023.
//

import SwiftUI



struct GeneratedQRView: View {
    let qrCode: QRCode?
    @StateObject private var vm = GeneratedQRViewModel()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationView {
            if let qrCode {
                ZStack {
                    BackgroundView()
                    VStack {
                        QrView(data: qrCode.imageData, size: 300)
                        Spacer()
                        ButtonView(title: "Save", action: { vm.showAlert() })
                    }
                    .padding()
                }
                .navigationTitle("Generated")
                .alert("QR title", isPresented: $vm.isShowAlert) {
                    TextField("Enter your name", text: $vm.qrTitle)
                    Button("Cancel", role: .cancel) { }
                    Button("Save", action: saveQR)
                } message: {
                    Text("Set title for your QR code.")
                }
            }
        }
    }
}

#Preview {
    GeneratedQRView(
        qrCode: QRCode(
            name: "name",
            text: "text",
            imageData: (UIImage(named: "defaultQRImage")?.pngData())!
        )
    )
}

extension GeneratedQRView {
    
    private func saveQR() {
        guard var qrCode else { return }
        qrCode.name = vm.qrTitle
        vm.addCode(qrCode)
        dismiss()
    }
}
