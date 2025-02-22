
import SwiftUI

struct QRCode: Identifiable, Codable, Equatable {
    
    var id = UUID().uuidString
    var name: String
    let textContent: String
    let foregroundColor: RGBColor
    let backgroundColor: RGBColor
    let imageData: Data
    let dateCreated: Date
    let backgroundImageData: Data?
    let logoImageData: Data?
    let type: String?
    let wifiSSID: String?
    let wifiPassword: String?
    let phoneNumber: String?
    
    init(
        id: String = UUID().uuidString,
        title: String,
        content: String,
        foregroundColor: RGBColor,
        backgroundColor: RGBColor,
        imageData: Data,
        dateCreated: Date,
        backgroundImageData: Data? = nil,
        logoImageData: Data? = nil,
        type: String?,
        wifiSSID: String? = nil,
        wifiPassword: String? = nil,
        phoneNumber: String? = nil
    ) {
        self.id = id
        self.name = title
        self.textContent = content
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.imageData = imageData
        self.dateCreated = dateCreated
        self.type = type
        self.backgroundImageData = backgroundImageData
        self.logoImageData = logoImageData
        self.wifiSSID = wifiSSID
        self.wifiPassword = wifiPassword
        self.phoneNumber = phoneNumber
    }
    
    init() {
        name = ""
        textContent = ""
        foregroundColor = RGBColor(color: .black)
        backgroundColor = RGBColor(color: .white)
        imageData = Data()
        dateCreated = Date()
        type = "Link, email, some text"
        backgroundImageData = nil
        logoImageData = nil
        wifiSSID = nil
        wifiPassword = nil
        phoneNumber = nil
    }
    
    static func == (lhs: QRCode, rhs: QRCode) -> Bool {
        if lhs.id == rhs.id,
           lhs.name == rhs.name,
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
