//
//  QRCodeView.swift
//  QRCodeSwiftUI
//
//  Created by Ульяна Гритчина on 12.11.2023.
//

import SwiftUI

@MainActor final class GeneratedQRViewModel: ObservableObject {
    
    @Published var qrTitle = ""
    @Published var isShowAlert = false
    
    var codes: [QRCode] = []
    
    init() {
        getItems()
    }
    
    func showAlert() {
        isShowAlert = true
    }
    
    func addCode(_ code: QRCode) {
        codes.append(code)
        saveCodes()
    }
    
  private func saveCodes() {
        if let encodedData = try? JSONEncoder().encode(codes) {
            UserDefaults.standard.set(encodedData, forKey: "codes_list")
        }
    }
    
    private func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: "codes_list"),
            let savedCodes = try? JSONDecoder().decode([QRCode].self, from: data)
        else { return }
        
        codes = savedCodes
    }
}

struct GeneratedQRView: View {
    let qrCodeImageData: Data?
    @StateObject private var vm = GeneratedQRViewModel()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                VStack {
                    qrCode
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
    
    private func saveQR() {
        let code = QRCode(name: vm.qrTitle, text: "", imageData: qrCodeImageData!)
        vm.addCode(code)
        dismiss()
    }
}
