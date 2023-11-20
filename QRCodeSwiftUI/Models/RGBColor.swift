//
//  RGBColor.swift
//  QRCodeSwiftUI
//
//  Created by Uliana Gritchina on 20.11.2023.
//

import SwiftUI

struct RGBColor: Codable {
    var red: Double = 1
    var green: Double = 1
    var blue: Double = 1
    var opacity: Double = 1
    
    init(color: Color) {
        guard let components = color.cgColor?.components else { return }
        red = components[0]
        green = components[1]
        blue = components[2]
        opacity = components[3]
    }
}
