
import SwiftUI

extension GenerateQRView {
    
    @MainActor final class ViewModel: ObservableObject {
        
        //MARK: - Published
        
        @Published var text = ""
        @Published var isShowingQR = false
        @Published var foregroundColor: Color = .black
        @Published var backgroundColor: Color = .white
        @Published var generatedQRCode: QRCode?
        @Published var editingQRCode: QRCode?
        
        // MARK: - Properties
        
        var qrCodeImageData: Data?
        
        private let qrGenerator = QRGeneratorManager.shared
        
        init(editingQRCode: QRCode? = nil) {
            self.editingQRCode = editingQRCode
            setEditingQrCode()
        }
        
        // MARK: - Computed Properties
        
        var isEditView: Bool {
            guard editingQRCode != nil else { return false }
            return true
        }
        
        var navigationTitle: String {
            editingQRCode?.title ?? "QR"
        }
        
        var generateButtonTitle: String {
            isEditView ? "Update" : "Generate"
        }
        
        // MARK: - Private Methods
        
        private func setEditingQrCode() {
            guard let editingQRCode else { return }
            text = editingQRCode.content
            setColorsForEditingQRCode()
        }
        
        private func setColorsForEditingQRCode() {
            if let foreground = editingQRCode?.foregroundColor {
                foregroundColor = Color(
                    red: foreground.red,
                    green: foreground.green,
                    blue: foreground.blue,
                    opacity: foreground.opacity
                )
            }
            if let background = editingQRCode?.backgroundColor {
                backgroundColor = Color(
                    red: background.red,
                    green: background.green,
                    blue: background.blue,
                    opacity: background.opacity
                )
            }
        }
        
        
        private func generateQRCode() {
            if let data = qrGenerator.generateQRCode(
                background: backgroundColor,
                foregroundColor: foregroundColor,
                content: text
            ) {
                qrCodeImageData = data
            }
            if let qrCodeImageData {
                generatedQRCode = QRCode(
                    title: "",
                    content: text,
                    foregroundColor: RGBColor(color: foregroundColor),
                    backgroundColor: RGBColor(color: backgroundColor),
                    imageData: qrCodeImageData,
                    dateCreated: Date()
                )
            }
        }
        
        // MARK: - Public Methods
        
        func showQRCodeView() {
            generateQRCode()
            isShowingQR = true
        }
        
        func rest() {
            text = ""
            foregroundColor = .black
            backgroundColor = .white
        }
        
    }
    
}
