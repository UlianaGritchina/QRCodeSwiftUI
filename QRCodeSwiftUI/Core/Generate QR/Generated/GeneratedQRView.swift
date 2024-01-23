//
//  QRCodeView.swift
//  QRCodeSwiftUI
//
//  Created by Ульяна Гритчина on 12.11.2023.
//

import SwiftUI

struct GeneratedQRView: View {
    let qrCode: QRCode?
    @StateObject private var vm = ViewModel()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationView {
            if let qrCode {
                ZStack {
                    BackgroundView()
                    qrCodeView
                    saveButtonView
                }
                .navigationTitle("Generated")
                .alert("QR title", isPresented: $vm.isShowAlert) {
                    TextField("title", text: $vm.qrTitle)
                        .submitLabel(.done)
                    Button("Cancel", role: .cancel) { }
                    Button("Save", action: saveQR)
                } message: {
                    Text("Set title for your QR code.")
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        ShareQRButton(qrCode: qrCode)
                    }
                }
            }
        }
    }
}

#Preview {
    GeneratedQRView(
        qrCode: QRCode(
            title: "name",
            content: "text",
            foregroundColor: RGBColor(color: .black),
            backgroundColor: RGBColor(color: .white),
            imageData: (UIImage(named: "defaultQRImage")?.pngData())!,
            dateCreated: Date(),
            type: "text"
        )
    )
}

extension GeneratedQRView {
    
    private var qrCodeView: some View {
        VStack {
            QrView(data: qrCode!.imageData, size: 300)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    private var saveButtonView: some View {
        VStack {
            Spacer()
            ButtonView(title: "Save", action: { vm.showAlert() })
                .padding()
                .padding(.bottom, UIScreen.main.bounds.height / 49)
        }
        .ignoresSafeArea()
    }
    
    private func saveQR() {
        guard var qrCode else { return }
        qrCode.name = vm.qrTitle
        vm.addCode(qrCode)
        dismiss()
    }
}
