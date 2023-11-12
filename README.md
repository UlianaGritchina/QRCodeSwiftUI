# QR-Code Generator

iOS App for generating custom QR-codes. SwiftUI MVVM

<img width="785" alt="gitQR" src="https://user-images.githubusercontent.com/95241900/190391625-ffd37d50-6575-4af0-9c2a-37079441b222.png">

QR generate method:
func generateQRCode(background: Color = .white, foregroundColor: Color = .black, content: String) -> Data? {
        var qrCodeImageData: Data?
        let backgroundColor = UIColor(background)
        let foregroundColor = UIColor(foregroundColor)
        let data = content.data(using: String.Encoding.utf8)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("H", forKey: "inputCorrectionLevel")
            colorFilter.setValue(filter.outputImage, forKey: "inputImage")
            colorFilter.setValue(CIColor(color: backgroundColor), forKey: "inputColor1") // Background
            colorFilter.setValue(CIColor(color: foregroundColor), forKey: "inputColor0") // Foreground
            guard let outputImage = colorFilter.outputImage else { return nil }
            let transform = CGAffineTransform(scaleX: 20, y: 20)
            let scaledCIImage = outputImage.transformed(by: transform)
            
            qrCodeImageData = UIImage(ciImage: scaledCIImage).pngData()
        }
        return qrCodeImageData
    }
