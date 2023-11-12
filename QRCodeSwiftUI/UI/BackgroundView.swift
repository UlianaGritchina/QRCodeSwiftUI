//
//  BackgroundView.swift
//  WordsAndCards
//
//  Created by Ульяна Гритчина on 21.02.2023.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Color("background").ignoresSafeArea()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
