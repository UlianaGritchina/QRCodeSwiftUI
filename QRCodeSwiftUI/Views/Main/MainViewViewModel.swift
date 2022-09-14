
import SwiftUI

class MainViewViewModel: ObservableObject {
    
    @Published var text = ""
    @Published var isShowingQR = false
    @Published var qrCodeColor: Color = .black
    @Published var bacgroundColor: Color = .white
    
    func showQRCodeView() {
        isShowingQR.toggle()
    }
    
    func rest() { text = "" }
  
}
