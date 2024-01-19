# QR-Code Generator

iOS App for generating custom QR-codes. SwiftUI MVVM

![Group 24](https://github.com/UlianaGritchina/QRCodeSwiftUI/assets/95241900/abeb882f-b1f9-463d-bc92-b6e58ad1e82b)

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
