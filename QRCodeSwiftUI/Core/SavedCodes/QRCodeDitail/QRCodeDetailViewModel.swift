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
    @Published var isShowEditView = false
    @Published var isShowAlert = false
    
    var qrCode: QRCode
    
    init(qrCode: QRCode) {
        self.qrCode = qrCode
        userDefaultsManager.setSavedQrs(for: &savedQrs)
    }
    
    var deleteAlertTitel: String {
        "Are you sure you want to delete QR"
        +
        " '\(qrCode.name)'"
    }
    
    var brightButtonImageName: String {
        isLightOn ? "sun.max" : "sun.min"
    }
    
    var qrCodeImageData: Data {
        qrCode.imageData
    }
    
    func deleteButtonDidTapp() {
        isShowAlert.toggle()
    }
    
    func deleteQRCode() {
        savedQrs.removeAll(where: { $0.id == qrCode.id })
        userDefaultsManager.saveQrs(savedQrs)
    }
    
    func didTapBrightButton() {
        isLightOn.toggle()
    }
    
    func showEditView() {
        isShowEditView = true
    }
    
    func updateQRInUserDefaults() {
        savedQrs.removeAll(where: {$0.id == qrCode.id })
        savedQrs.append(qrCode)
        userDefaultsManager.saveQrs(savedQrs)
    }
    
}
