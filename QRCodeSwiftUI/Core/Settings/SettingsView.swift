//
//  InfoView.swift
//  QRCodeSwiftUI
//
//  Created by Ульяна Гритчина on 15.11.2023.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                ScrollView {
                    VStack(spacing: 30) {
                        text
                        donatesList
                        removeAddsButton
                        appStoreButtons
                    }
                    .padding()
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    
    private var text: some View {
        Text("If you like the app you can support the developer.")
            .multilineTextAlignment(.center)
            .font(.headline)
    }
    
    private var donatesList: some View {
        VStack {
            ForEach(viewModel.prices, id: \.self) { price in
                donateCell(price: price, action: {})
            }
        }
    }
    
    private var removeAddsButton: some View {
        Button(action: { RequestReviewManager.shared.showReviewView() }, label: {
            Text("Remove adds for $ 7")
                .font(.headline)
                .foregroundStyle(.white)
                .font(.headline)
                .frame(height: 45)
                .frame(maxWidth: 700)
                .background(.blue)
                .cornerRadius(10)
        })
    }
    
    private var appStoreButtons: some View {
        HStack(spacing: 15) {
            rateTheAppButton
            writeReviewLink
        }
    }
    
    private var rateTheAppButton: some View {
        Button(action: { RequestReviewManager.shared.showReviewView() }, label: {
            Text("Rate the app")
                .font(.headline)
                .foregroundStyle(.white)
                .font(.headline)
                .frame(height: 45)
                .frame(maxWidth: 700)
                .background(.blue)
                .cornerRadius(10)
        })
    }
    
    private var writeReviewLink: some View {
        Link(destination: viewModel.writeReviewURL) {
            Text("Write a review")
                .font(.headline)
                .foregroundStyle(.white)
                .font(.headline)
                .frame(height: 45)
                .frame(maxWidth: 700)
                .background(.blue)
                .cornerRadius(10)
        }
    }
    
    private func donateCell(
        price: String,
        action: @escaping () -> ()
    ) -> some View {
        Button(action: action, label: {
            HStack {
                Text(price)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding()
            .background(Color("cardBackground"))
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            
        })
    }
    
}
