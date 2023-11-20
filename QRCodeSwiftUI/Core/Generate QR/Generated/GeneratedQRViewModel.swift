//
//  GeneratedQRViewModel.swift
//  QRCodeSwiftUI
//
//  Created by Ульяна Гритчина on 13.11.2023.
//

import Foundation

extension GeneratedQRView {
    @MainActor final class ViewModel: ObservableObject {
        
        @Published var qrTitle = ""
        @Published var isShowAlert = false
        
        private let userDefaultsManager = UserDefaultsManager.shared
        var codes: [QRCode] = []
        
        init() {
            setQRs()
        }
        
        private func setQRs() {
            userDefaultsManager.setSavedQrs(for: &codes)
        }
        
        func showAlert() {
            isShowAlert = true
        }
        
        func addCode(_ code: QRCode) {
            codes.append(code)
            userDefaultsManager.saveQrs(codes)
        }
        
    }
    
}
