
import SwiftUI

class MainViewModel: ObservableObject {
    
    @Published var text = ""
    @Published var isShowingQR = false
    @Published var qrCodeColor: Color = .black
    @Published var backgroundColor: Color = .white
    @Published var selectedEye = "square"
    @Published var selectedData = "squareData"
    @Published var isShowingEyes = false
    @Published var isShowingData = false
    
    let eyes = ["square",
                "roundedRect",
                "roundedPointingIn",
                "roundedOuter",
                "leaf",
                "circle",
                "squircle",
                "barsVertical",
                "barsHorizontal"]
    
    let data = ["curvePixelData",
                "roundedPathData",
                "roundedOuterData",
                "circleData",
                "squareData"]
    
    func showQRCodeView() {
        isShowingQR.toggle()
    }
    
    func rest() { text = "" }
    
    func selectEye(index: Int) {
        selectedEye = eyes[index]
        withAnimation(.spring()) {
            isShowingEyes.toggle()
        }
    }
    
    func selectData(index: Int) {
        selectedData = data[index]
        withAnimation(.spring()) {
            isShowingData.toggle()
        }
    }
    
    func showDataSheet() {
        withAnimation(.spring()) {
            isShowingData.toggle()
        }
    }
    
    func showEyesSheet() {
        withAnimation(.spring()) {
            isShowingEyes.toggle()
        }
    }
    
    
}
