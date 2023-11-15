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
            MainView()
                .tabItem {
                    Label("Generate QR", systemImage: "qrcode")
                }
            
            SavedCodesView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
            InfoView()
                .tabItem {
                    Label("Info", systemImage: "info.circle")
                }
        }
    }
}

struct TabViewView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewView()
    }
}
