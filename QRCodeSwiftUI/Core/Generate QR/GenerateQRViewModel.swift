
import SwiftUI

extension GenerateQRView {
    
    @MainActor final class ViewModel: ObservableObject {
        
        //MARK: - Published
        
        @Published var content = ""
        @Published var qrTitle = ""
        @Published var isShowingQR = false
        @Published var foregroundColor: Color = .black
        @Published var backgroundColor: Color = .white
        @Published var generatedQRCode: QRCode?
        @Published var editingQRCode: QRCode
        
        // MARK: - Properties
        
        var isEditView: Bool
        var qrCodeImageData: Data?
        
        private let qrGenerator = QRGeneratorManager.shared
        
        init(editingQRCode: QRCode, isEditView: Bool) {
            self.editingQRCode = editingQRCode
            self.isEditView = isEditView
            setEditingQrCode()
            qrTitle = editingQRCode.title
        }
        
        // MARK: - Computed Properties
        
        var navigationTitle: String {
            isEditView ? "Edit" : "Qr"
        }
        
        var generateButtonTitle: String {
            isEditView ? "Update" : "Generate"
        }
        
        // MARK: - Private Methods
        
        private func setEditingQrCode() {
            if isEditView {
                content = editingQRCode.content
                setColorsForEditingQRCode()
            }
        }
        
        private func setColorsForEditingQRCode() {
            let foreground = editingQRCode.foregroundColor
            foregroundColor = Color(
                red: foreground.red,
                green: foreground.green,
                blue: foreground.blue,
                opacity: foreground.opacity
            )
            let background = editingQRCode.backgroundColor
            backgroundColor = Color(
                red: background.red,
                green: background.green,
                blue: background.blue,
                opacity: background.opacity
            )
        }
        
        
        private func generateQRCode() {
            if let data = qrGenerator.generateQRCode(
                background: backgroundColor,
                foregroundColor: foregroundColor,
                content: content
            ) {
                qrCodeImageData = data
            }
            if let qrCodeImageData {
                generatedQRCode = QRCode(
                    title: "",
                    content: content,
                    foregroundColor: RGBColor(color: foregroundColor),
                    backgroundColor: RGBColor(color: backgroundColor),
                    imageData: qrCodeImageData,
                    dateCreated: Date()
                )
            }
        }
        
        // MARK: - Public Methods
        
        func generateButtonTapped() {
            generateQRCode()
            if isEditView {
                if let generatedQRCode  {
                    editingQRCode = QRCode(
                        id: editingQRCode.id,
                        title: qrTitle,
                        content: generatedQRCode.content,
                        foregroundColor: generatedQRCode.foregroundColor,
                        backgroundColor: generatedQRCode.backgroundColor,
                        imageData: generatedQRCode.imageData,
                        dateCreated: editingQRCode.dateCreated
                    )
                }
            } else {
                isShowingQR = true
            }
        }
        
        func rest() {
            content = ""
            foregroundColor = .black
            backgroundColor = .white
        }
        
        func swapColors() {
            let temporaryForegroundColor = foregroundColor
            foregroundColor = backgroundColor
            backgroundColor = temporaryForegroundColor
        }
    }
    
}
