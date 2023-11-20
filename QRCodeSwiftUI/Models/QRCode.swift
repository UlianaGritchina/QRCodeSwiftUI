
import SwiftUI

struct QRCode: Identifiable, Codable, Equatable {
    
    var id = UUID().uuidString
    var title: String
    let content: String
    let foregroundColor: RGBColor
    let backgroundColor: RGBColor
    let imageData: Data
    let dateCreated: Date
    
    init(
        id: String = UUID().uuidString,
        title: String,
        content: String,
        foregroundColor: RGBColor,
        backgroundColor: RGBColor,
        imageData: Data,
        dateCreated: Date
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.imageData = imageData
        self.dateCreated = dateCreated
    }
    
    init() {
        title = ""
        content = ""
        foregroundColor = RGBColor(color: .black)
        backgroundColor = RGBColor(color: .white)
        imageData = Data()
        dateCreated = Date()
    }
    
    static func == (lhs: QRCode, rhs: QRCode) -> Bool {
        if lhs.id == rhs.id,
           lhs.title == rhs.title,
           lhs.content == rhs.content,
           lhs.imageData == rhs.imageData {
            return true
        } else {
            return false
        }
    }
    
}
