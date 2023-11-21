//
//  InfoView.swift
//  QRCodeSwiftUI
//
//  Created by Ульяна Гритчина on 15.11.2023.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                textView
                supportButton(title: "Rate the app", action: { 
                    RequestReviewManager.shared.showReviewView()
                })
                supportButton(title: "Write a review", action: {
                    
                })
            }
            .navigationTitle("Settings")
            .padding(.horizontal)
            .background(BackgroundView())
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    
    private var textView: some View {
        LinearGradient(colors: [.blue, .green], startPoint: .leading, endPoint: .trailing)
            .frame(height: 80)
            .opacity(0.9)
            .mask {
                VStack {
                    Text("My QR - application for generating QR-codes. If you like this app you can support it.")
                    //                    Text("If you like this app you can support it.")
                }
                .multilineTextAlignment(.center)
                .font(.headline)
            }
    }
    
    private func supportButton(title: String, action: @escaping () -> ()) -> some View {
        Button(action: action, label: {
            Text(title)
                .foregroundStyle(.blue)
                .font(.headline)
                .frame(height: 45)
                .frame(maxWidth: 700)
                .background(Color("cardBackground"))
                .cornerRadius(10)
        })
    }
    
}
