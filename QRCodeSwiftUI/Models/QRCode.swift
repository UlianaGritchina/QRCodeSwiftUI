
import SwiftUI

struct QRCode: Identifiable, Codable {
    var id = UUID().uuidString
    var title: String
    let content: String
    let foregroundColor: RGBColor
    let backgroundColor: RGBColor
    let imageData: Data
    let dateCreated: Date
}

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

