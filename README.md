# QR-Code Generator

iOS App for generating custom QR-codes. SwiftUI MVVM

<img width="4218" alt="QRPreview" src="https://github.com/UlianaGritchina/QRCodeSwiftUI/assets/95241900/052f820d-cecd-4a5e-8faf-cd6e1f953d2e">

QR generate method:
```
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

```
