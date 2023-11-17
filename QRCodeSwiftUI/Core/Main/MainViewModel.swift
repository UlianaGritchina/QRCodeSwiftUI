
import SwiftUI

class MainViewModel: ObservableObject {
    
    //MARK: - Published
    
    @Published var text = ""
    @Published var isShowingQR = false
    @Published var qrCodeColor: Color = .black
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
        editingQRCode?.name ?? "QR"
    }
    
    var generateButtonTitle: String {
        isEditView ? "Update" : "Generate"
    }
    
    // MARK: - Private Methods
    
    private func setEditingQrCode() {
        guard let editingQRCode else { return }
        text = editingQRCode.text
    }
    
    private func generateQRCode() {
        if let data = qrGenerator.generateQRCode(
            background: backgroundColor,
            foregroundColor: qrCodeColor,
            content: text
        ) {
            qrCodeImageData = data
        }
        if let qrCodeImageData {
            generatedQRCode = QRCode(
                name: "",
                text: text,
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
        qrCodeColor = .black
        backgroundColor = .white
    }
    
}
