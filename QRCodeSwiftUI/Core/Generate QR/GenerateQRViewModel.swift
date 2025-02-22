
import SwiftUI


enum QRImageType {
    case background
    case logo
}

extension GenerateQRView {
    
    enum QRType: String, CaseIterable, Identifiable  {
        
        var id: String {
            switch self {
            case .text:
                return "text"
            case .wifi:
                return "wifi"
            default:
                return UUID().uuidString
            }
        }

        case text = "Link, email, some text"
        case wifi = "Wi-Fi"
        case phone = "Phone number"
        case massage = "Massage"
    }
    
    @MainActor final class ViewModel: ObservableObject {
        
        //MARK: - Published
        
        @Published var text = ""
        @Published var wifiSSID = ""
        @Published var wifiPassword = ""
        @Published var phoneNumber = ""
        @Published var foregroundColor: Color = .black
        @Published var backgroundColor: Color = .white
        @Published var backgroundImageData: Data?
        @Published var logoImageData: Data?
        @Published var qrCodeName = ""
        @Published var isShowingQR = false
        @Published var isShowPhotoPicker = false
        @Published var generatedQRCode: QRCode?
        @Published var editingQRCode: QRCode
        @Published var qrType: QRType = .text
        @Published var qrImageType: QRImageType = .background
        
        @AppStorage("isFirstEnter") var isFirstEnter: Bool = true
        
        // MARK: - Properties
        
        var isEditView: Bool
        var qrCodeImageData: Data?
        
        private let qrGenerator = QRGeneratorManager.shared
        
        init(editingQRCode: QRCode, isEditView: Bool) {
            self.editingQRCode = editingQRCode
            self.isEditView = isEditView
            setupEditingQrCode()
            qrCodeName = editingQRCode.name
        }
        
        // MARK: - Computed Properties
        
        var navigationTitle: String {
            isEditView ? "Edit" : "Qr"
        }
        
        var generateButtonTitle: String {
            isEditView ? "Update" : "Generate"
        }
        
        // MARK: - Private Methods
        
        private func generateQRCode() {
            let qrContent = switch qrType {
            case .text:  text
            case .wifi:  "WIFI:T:WPA;S:\(wifiSSID);P\(wifiPassword);;"
            case .phone: "tel:+\(phoneNumber)"
            default:
                ""
            }
            
            let logoImage = UIImage(data: logoImageData ?? Data())
            let background = UIImage(data: backgroundImageData ?? Data())
            
            if let data = qrGenerator.generateQRCode(
                background: backgroundColor,
                foregroundColor: foregroundColor,
                content: qrContent,
                overlayImage: logoImage,
                backgroundImage: background
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
                        backgroundImageData: backgroundImageData,
                        logoImageData: logoImageData,
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
                        backgroundImageData: backgroundImageData,
                        logoImageData: logoImageData,
                        type: qrType.rawValue,
                        wifiSSID: wifiSSID,
                        wifiPassword: wifiPassword
                    )
                case .phone:
                    generatedQRCode = QRCode(
                        title: "",
                        content: "",
                        foregroundColor: RGBColor(color: foregroundColor),
                        backgroundColor: RGBColor(color: backgroundColor),
                        imageData: data,
                        dateCreated: Date(),
                        backgroundImageData: backgroundImageData,
                        logoImageData: logoImageData,
                        type: qrType.rawValue,
                        phoneNumber: phoneNumber
                    )
                default:
                    break
                }
            }
        }
        
        // MARK:  Editing QR-Code
        
        private func setupEditingQrCode() {
            if isEditView {
                text = editingQRCode.textContent
                setColorsForEditingQRCode()
                getEditingQRType()
                setEditingQRCodeContent()
                backgroundImageData = editingQRCode.backgroundImageData
                logoImageData = editingQRCode.logoImageData
            }
        }
        
        private func getEditingQRType() {
            for type in QRType.allCases {
                if type.rawValue == editingQRCode.type {
                    qrType = type
                }
            }
        }
        
        func setEditingQRCodeContent() {
            switch qrType {
            case .text:
                text = editingQRCode.textContent
            case .wifi:
                wifiSSID = editingQRCode.wifiSSID ?? ""
                wifiPassword = editingQRCode.wifiPassword ?? ""
            case .phone:
                phoneNumber = editingQRCode.phoneNumber ?? ""
            default:
                break
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
        
        // MARK: - Public Methods
        
        func generateButtonTapped() {
            generateQRCode()
            if isEditView {
                if let generatedQRCode  {
                    switch qrType {
                    case .text:
                        editingQRCode = QRCode(
                            id: editingQRCode.id,
                            title: qrCodeName,
                            content: generatedQRCode.textContent,
                            foregroundColor: generatedQRCode.foregroundColor,
                            backgroundColor: generatedQRCode.backgroundColor,
                            imageData: generatedQRCode.imageData,
                            dateCreated: editingQRCode.dateCreated,
                            backgroundImageData: generatedQRCode.backgroundImageData,
                            logoImageData: generatedQRCode.logoImageData,
                            type: qrType.rawValue
                        )
                    case .wifi:
                        editingQRCode = QRCode(
                            id: editingQRCode.id,
                            title: qrCodeName,
                            content: "",
                            foregroundColor: generatedQRCode.foregroundColor,
                            backgroundColor: generatedQRCode.backgroundColor,
                            imageData: generatedQRCode.imageData,
                            dateCreated: editingQRCode.dateCreated,
                            backgroundImageData: generatedQRCode.backgroundImageData,
                            logoImageData: generatedQRCode.logoImageData,
                            type: qrType.rawValue,
                            wifiSSID: wifiSSID,
                            wifiPassword: wifiPassword
                        )
                        
                    case .phone:
                        editingQRCode = QRCode(
                            id: editingQRCode.id,
                            title: qrCodeName,
                            content: "",
                            foregroundColor: generatedQRCode.foregroundColor,
                            backgroundColor: generatedQRCode.backgroundColor,
                            imageData: generatedQRCode.imageData,
                            dateCreated: editingQRCode.dateCreated,
                            backgroundImageData: generatedQRCode.backgroundImageData,
                            logoImageData: generatedQRCode.logoImageData,
                            type: qrType.rawValue,
                            phoneNumber: generatedQRCode.phoneNumber
                        )

                    default:
                        break
                    }
                }
            } else {
                isShowingQR = true
            }
        }
        
        func reset() {
            switch qrType {
            case .text:
                text = ""
            case .wifi:
                wifiSSID = ""
                wifiPassword = ""
                
            case .phone:
                phoneNumber = ""
            default: break
            }
            foregroundColor = .black
            backgroundColor = .white
            backgroundImageData = nil
            logoImageData = nil
        }
        
        func swapColors() {
            let temporaryForegroundColor = foregroundColor
            foregroundColor = backgroundColor
            backgroundColor = temporaryForegroundColor
        }
    }
    
}
