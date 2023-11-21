//
//  TabViewView.swift
//  WordsAndCards
//
//  Created by Ульяна Гритчина on 09.05.2023.
//

import SwiftUI

struct TabViewView: View {
    var body: some View {
        TabView {
            GenerateQRView(editingQR: .constant(QRCode()))
                .tabItem {
                    Label("Generate QR", systemImage: "qrcode")
                }
            
            SavedCodesView()
                .tabItem {
                    Label("Saved", systemImage: "star.square")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct TabViewView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewView()
    }
}
