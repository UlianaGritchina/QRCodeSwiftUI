//
//  SabedQRCodesManager.swift
//  QRCodeSwiftUI
//
//  Created by Ульяна Гритчина on 13.11.2023.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() { }
    
    let codesKey: String = "codes_list"
    
    func saveQrs(_ codes: [QRCode]) {
        if let encodedData = try? JSONEncoder().encode(codes) {
            UserDefaults.standard.set(encodedData, forKey: codesKey)
        }
    }
    
    func getSavedQRs() -> [QRCode] {
        guard
            let data = UserDefaults.standard.data(forKey: codesKey),
            let savedCodes = try? JSONDecoder().decode([QRCode].self, from: data)
        else { return [] }
        
        return savedCodes
    }
    
}
