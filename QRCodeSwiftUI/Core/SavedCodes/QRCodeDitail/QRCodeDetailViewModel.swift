//
//  QRCodeDetailViewModel.swift
//  QRCodeSwiftUI
//
//  Created by Uliana Gritchina on 15.11.2023.
//

import Foundation

@MainActor final class QRCodeDetailViewModel: ObservableObject {
    
    private var savedQrs: [QRCode] = []
    private let userDefaultsManager = UserDefaultsManager.shared
    
    @Published var isLightOn = false
    
    var qrCode: QRCode
    
    init(qrCode: QRCode) {
        self.qrCode = qrCode
        savedQrs = userDefaultsManager.getSavedQRs()
    }
    
    var qrCodeImageData: Data {
        qrCode.imageData
    }
    
    func deleteQRCode() {
        savedQrs.removeAll(where: { $0.id == qrCode.id })
        userDefaultsManager.saveQrs(savedQrs)
    }
    
    func didTapBrightButton() {
        isLightOn.toggle()
    }
    
}
