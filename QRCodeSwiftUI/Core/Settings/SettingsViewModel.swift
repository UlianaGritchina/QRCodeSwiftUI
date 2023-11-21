//
//  SettingsViewModel.swift
//  QRCodeSwiftUI
//
//  Created by Ульяна Гритчина on 21.11.2023.
//

import Foundation

extension SettingsView {
    
    @MainActor final class ViewModel: ObservableObject {
        
        let prices = ["$ 0.99", "$ 4.99", "$ 9.99", "$ 100"]
        let writeReviewURL = URL(
            string: "https://apps.apple.com/ru/app/my-qr/id1644582305?action=write-review"
        )!
        
    }
    
}
