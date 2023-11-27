
import SwiftUI

struct QRCode: Identifiable, Codable, Equatable {
    
    var id = UUID().uuidString
    var title: String
    let textContent: String
    let foregroundColor: RGBColor
    let backgroundColor: RGBColor
    let imageData: Data
    let dateCreated: Date
    let type: String
    let wifiSSID: String?
    let wifiPassword: String?
    
    init(
        id: String = UUID().uuidString,
        title: String,
        content: String,
        foregroundColor: RGBColor,
        backgroundColor: RGBColor,
        imageData: Data,
        dateCreated: Date,
        type: String,
        wifiSSID: String? = nil,
        wifiPassword: String? = nil
    ) {
        self.id = id
        self.title = title
        self.textContent = content
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.imageData = imageData
        self.dateCreated = dateCreated
        self.type = type
        self.wifiSSID = wifiSSID
        self.wifiPassword = wifiPassword
    }
    
    init() {
        title = ""
        textContent = ""
        foregroundColor = RGBColor(color: .black)
        backgroundColor = RGBColor(color: .white)
        imageData = Data()
        dateCreated = Date()
        type = "text"
        wifiSSID = nil
        wifiPassword = nil
    }
    
    static func == (lhs: QRCode, rhs: QRCode) -> Bool {
        if lhs.id == rhs.id,
           lhs.title == rhs.title,
           lhs.textContent == rhs.textContent,
           lhs.wifiSSID == rhs.wifiSSID,
           lhs.wifiPassword == rhs.wifiPassword,
           lhs.type == rhs.type,
           lhs.imageData == rhs.imageData {
            return true
        } else {
            return false
        }
    }
    
}
