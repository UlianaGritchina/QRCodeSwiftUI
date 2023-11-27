
import SwiftUI

extension GenerateQRView {
    
    enum QRType: String, CaseIterable  {
        case text = "Link, email, some text"
        case wifi = "Wi-Fi"
    }
    
    @MainActor final class ViewModel: ObservableObject {
        
        //MARK: - Published
        
        @Published var text = ""
        @Published var wifiSSID = ""
        @Published var wifiPassword = ""
        @Published var foregroundColor: Color = .black
        @Published var backgroundColor: Color = .white
        @Published var qrTitle = ""
        @Published var isShowingQR = false
        @Published var generatedQRCode: QRCode?
        @Published var editingQRCode: QRCode
        @Published var qrType: QRType = .text
        
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
                text = editingQRCode.textContent
                setColorsForEditingQRCode()
                if let wifiSSID = editingQRCode.wifiSSID, let wifiPassword = editingQRCode.wifiPassword {
                    qrType = .wifi
                    self.wifiSSID = wifiSSID
                    self.wifiPassword = wifiPassword
                }
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
            let qrContent = switch qrType {
            case .text:  text
            case .wifi:  "WIFI:T:WPA;S:\(wifiSSID);P\(wifiPassword);;"
            }
            if let data = qrGenerator.generateQRCode(
                background: backgroundColor,
                foregroundColor: foregroundColor,
                content: qrContent
            ) {
                switch qrType {
                case .text:
                    generatedQRCode = QRCode(
                        title: "",
                        content: text,
                        foregroundColor: RGBColor(color: foregroundColor),
                        backgroundColor: RGBColor(color: backgroundColor),
                        imageData: data,
                        dateCreated: Date(),
                        type: qrType.rawValue
                    )
                case .wifi:
                    generatedQRCode = QRCode(
                        title: "",
                        content: "",
                        foregroundColor: RGBColor(color: foregroundColor),
                        backgroundColor: RGBColor(color: backgroundColor),
                        imageData: data,
                        dateCreated: Date(),
                        type: qrType.rawValue,
                        wifiSSID: wifiSSID,
                        wifiPassword: wifiPassword
                    )
                    
                }
            }
        }
        
        // MARK: - Public Methods
        
        func generateButtonTapped() {
            generateQRCode()
            if isEditView {
                if let generatedQRCode  {
                    switch qrType {
                    case .text:
                        editingQRCode = QRCode(
                            id: editingQRCode.id,
                            title: qrTitle,
                            content: generatedQRCode.textContent,
                            foregroundColor: generatedQRCode.foregroundColor,
                            backgroundColor: generatedQRCode.backgroundColor,
                            imageData: generatedQRCode.imageData,
                            dateCreated: editingQRCode.dateCreated,
                            type: qrType.rawValue
                        )
                    case .wifi:
                        editingQRCode = QRCode(
                            id: editingQRCode.id,
                            title: qrTitle,
                            content: "",
                            foregroundColor: generatedQRCode.foregroundColor,
                            backgroundColor: generatedQRCode.backgroundColor,
                            imageData: generatedQRCode.imageData,
                            dateCreated: editingQRCode.dateCreated,
                            type: qrType.rawValue,
                            wifiSSID: wifiSSID,
                            wifiPassword: wifiPassword
                        )
                    }
                }
            } else {
                isShowingQR = true
            }
        }
        
        func rest() {
            switch qrType {
            case .text:
                text = ""
            case .wifi:
                wifiSSID = ""
                wifiPassword = ""
            }
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
