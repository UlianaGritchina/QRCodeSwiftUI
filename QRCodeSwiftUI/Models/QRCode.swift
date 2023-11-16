
import UIKit

struct QRCode: Identifiable, Codable {
    var id = UUID().uuidString
    var name: String
    let text: String
    let imageData: Data
    let dateCreated: Date
}
