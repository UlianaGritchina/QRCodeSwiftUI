
import SwiftUI

class MainViewModel: ObservableObject {
    
    //MARK: - Published
    
    @Published var text = ""
    @Published var isShowingQR = false
    @Published var qrCodeColor: Color = .black
    @Published var backgroundColor: Color = .white
    var qrCodeImageData: Data?
    @Published var generatedQRCode: QRCode?
    
    // MARK: - Properties
    
    private let qrGenerator = QRGeneratorManager.shared
    
    // MARK: - Private Methods
    
    private func generateQRCode() {
        if let data = qrGenerator.generateQRCode(
            background: backgroundColor,
            foregroundColor: qrCodeColor,
            content: text
        ) {
            qrCodeImageData = data
        }
        if let qrCodeImageData {
            generatedQRCode = QRCode(name: "", text: text, imageData: qrCodeImageData)
        }
    }
    
    // MARK: - Public Methods
    
    func showQRCodeView() {
        generateQRCode()
        isShowingQR = true
    }
    
    func rest() {
        text = ""
        qrCodeColor = .black
        backgroundColor = .white
    }
    
}
