import SwiftUI
import CoreImage.CIFilterBuiltins

class QRCodeSheetViewViewModel: ObservableObject {
    
    @Published var startingOffsetY: CGFloat = 0
    @Published var currentDragOffsetY: CGFloat = 0
    @Published var endingOffsetY: CGFloat = 0
    
    private let noQRCodeImage = UIImage(systemName: "questionmark.square.dashed")
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    func generateQRCode(from string: String, color: UIColor, color2: UIColor) -> UIImage {
        let data = string.data(using: String.Encoding.utf8)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            guard let colorFilter = CIFilter(name: "CIFalseColor") else { return noQRCodeImage! }
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("H", forKey: "inputCorrectionLevel")
            colorFilter.setValue(filter.outputImage, forKey: "inputImage")
            colorFilter.setValue(CIColor(color: color2), forKey: "inputColor1") // Background
            colorFilter.setValue(CIColor(color: color), forKey: "inputColor0") // Foreground
            guard let outputImage = colorFilter.outputImage else { return noQRCodeImage! }
            //guard let qrCodeImage = context.createCGImage(outputImage, from: outputImage.extent)
            //else { return UIImage() }
            let transform = CGAffineTransform(scaleX: 20, y: 20)
            let scaledCIImage = outputImage.transformed(by: transform)
            return UIImage(ciImage: scaledCIImage)
        }
        return noQRCodeImage!
    }
}
