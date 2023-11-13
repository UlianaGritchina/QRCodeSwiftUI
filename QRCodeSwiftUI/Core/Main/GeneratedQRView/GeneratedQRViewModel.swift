//
//  GeneratedQRViewModel.swift
//  QRCodeSwiftUI
//
//  Created by Ульяна Гритчина on 13.11.2023.
//

import Foundation

@MainActor final class GeneratedQRViewModel: ObservableObject {
    
    @Published var qrTitle = ""
    @Published var isShowAlert = false
    
    private let userDefaultsManager = UserDefaultsManager.shared
    var codes: [QRCode] = []
    
    init() {
        setQRs()
    }
    
    private func setQRs() {
        codes = userDefaultsManager.getSavedQRs()
    }
    
    func showAlert() {
        isShowAlert = true
    }
    
    func addCode(_ code: QRCode) {
        codes.append(code)
        userDefaultsManager.saveQrs(codes)
    }
    
}
