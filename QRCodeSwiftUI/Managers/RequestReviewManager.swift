//
//  RequestReviewManager.swift
//  WordsAndCards
//
//  Created by Ульяна Гритчина on 04.03.2023.
//

import SwiftUI
import StoreKit

class RequestReviewManager {
    static let shared = RequestReviewManager()
    
    func showReviewView() {
        if let scene = UIApplication.shared.connectedScenes.first(where: {$0.activationState == .foregroundActive}) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}
