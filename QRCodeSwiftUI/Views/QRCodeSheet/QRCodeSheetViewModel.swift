import SwiftUI
import CoreImage.CIFilterBuiltins

class QRCodeSheetViewModel: ObservableObject {
    
    @Published var startingOffsetY: CGFloat = 0
    @Published var currentDragOffsetY: CGFloat = 0
    @Published var endingOffsetY: CGFloat = 0
    @Published var name = ""
    @Published var isGoingToSave = false
    @Published var qrImageData: Data = Data()
    @Published var helloFriendOpacity: Double = 0
    
    var text: String
    var color: Color
    var color2: Color
    
    private let noQRCodeImage = UIImage(systemName: "questionmark.square.dashed")
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    init(text: String, color1: Color, color2: Color) {
        self.text = text
        self.color = color1
        self.color2 = color2
        generateQRCode()
    }
    
    private func generateQRCode() {
        let foregroundColor = UIColor(color)
        let backgroundColor = UIColor(color2)
        let data = text.data(using: String.Encoding.utf8)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            guard let colorFilter = CIFilter(name: "CIFalseColor") else { return  }
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("H", forKey: "inputCorrectionLevel")
            colorFilter.setValue(filter.outputImage, forKey: "inputImage")
            colorFilter.setValue(CIColor(color: backgroundColor), forKey: "inputColor1") // Background
            colorFilter.setValue(CIColor(color: foregroundColor), forKey: "inputColor0") // Foreground
            guard let outputImage = colorFilter.outputImage else { return }
            let transform = CGAffineTransform(scaleX: 20, y: 20)
            let scaledCIImage = outputImage.transformed(by: transform)
            qrImageData = UIImage(ciImage: scaledCIImage).pngData() ?? Data()
        }
    }
    
}
