
import SwiftUI

class MainViewModel: ObservableObject {
    
    @Published var text = ""
    @Published var isShowingQR = false
    @Published var qrCodeColor: Color = .black
    @Published var backgroundColor: Color = .white

    func showQRCodeView() {
        isShowingQR.toggle()
    }
    
    func getQRCodeViewModel() -> QRCodeSheetViewModel {
        QRCodeSheetViewModel(text: text, color1: qrCodeColor, color2: backgroundColor)
    }
    
    func rest() {
        text = ""
        qrCodeColor = .black
        backgroundColor = .white
    }
    
}
