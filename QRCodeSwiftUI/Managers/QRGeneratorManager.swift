//
//  QRGeneratorManager.swift
//  QRCodeSwiftUI
//
//  Created by Ульяна Гритчина on 12.11.2023.
//

import SwiftUI

final class QRGeneratorManager {
    static let shared = QRGeneratorManager()
    private init() { }
    
    func generateQRCode(background: Color = .white, foregroundColor: Color = .black, content: String) -> Data? {
        var qrCodeImageData: Data?
        let backgroundColor = UIColor(background)
        let foregroundColor = UIColor(foregroundColor)
        let data = content.data(using: String.Encoding.utf8)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
            filter.setValue(data, forKey: "inputMessage")
            // filter.setValue("H", forKey: "inputCorrectionLevel")
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
    
    func generateQRCode(background: Color = .white, foregroundColor: Color = .black, content: String, overlayImage: UIImage? = nil, backgroundImage: UIImage? = nil) -> Data? {
        var qrCodeImageData: Data?
        let backgroundColor = UIColor(background)
        let foregroundColor = UIColor(foregroundColor)
        let data = content.data(using: String.Encoding.utf8)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
            filter.setValue(data, forKey: "inputMessage")
            colorFilter.setValue(filter.outputImage, forKey: "inputImage")
            colorFilter.setValue(CIColor(color: backgroundColor), forKey: "inputColor1") // Background
            colorFilter.setValue(CIColor(color: foregroundColor), forKey: "inputColor0") // Foreground
            
            guard let outputImage = colorFilter.outputImage else { return nil }
            let transform = CGAffineTransform(scaleX: 20, y: 20)
            let scaledCIImage = outputImage.transformed(by: transform)
            
            // Создаем UIImage из CIImage
            let qrCodeImage = UIImage(ciImage: scaledCIImage)
            
            // Начинаем графический контекст
            UIGraphicsBeginImageContext(qrCodeImage.size)
            
            // Рисуем фоновое изображение, если оно предоставлено
            if let backgroundImage = backgroundImage {
                backgroundImage.draw(in: CGRect(origin: .zero, size: CGSize(width: qrCodeImage.size.width + 20, height: qrCodeImage.size.height + 20)))
            } else {
                // Если фон не задан, рисуем цветной фон
                backgroundColor.setFill()
                UIRectFill(CGRect(origin: .zero, size: qrCodeImage.size))
            }
            
            // Рисуем QR-код
            qrCodeImage.draw(in: CGRect(origin: .zero, size: qrCodeImage.size))
            
            // Если есть изображение для наложения, добавляем его
            if let overlayImage = overlayImage {
                print(overlayImage)
                // Определяем размер и позицию наложенного изображения
                let overlaySize = CGSize(width: qrCodeImage.size.width / 5, height: qrCodeImage.size.height / 5) // Пример размера
                let overlayOrigin = CGPoint(x: (qrCodeImage.size.width - overlaySize.width) / 2,
                                            y: (qrCodeImage.size.height - overlaySize.height) / 2) // Центрируем наложенное изображение
                
                let rect = CGRect(origin: overlayOrigin, size: overlaySize)
                UIBezierPath(roundedRect: rect, cornerRadius: 10).addClip()
                overlayImage.draw(in: rect)
            }
            
            // Получаем итоговое изображение
            let finalImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            qrCodeImageData = finalImage?.pngData()
        }
        
        return qrCodeImageData
    }
}
