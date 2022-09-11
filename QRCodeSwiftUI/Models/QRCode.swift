
import UIKit

struct QRCode: Identifiable, Codable {
    var id = UUID().uuidString
    let name: String
    let text: String
    let imageData: Data
}
