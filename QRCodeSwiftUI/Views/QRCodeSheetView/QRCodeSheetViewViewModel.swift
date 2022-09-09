import SwiftUI
import CoreImage.CIFilterBuiltins

class QRCodeSheetViewViewModel: ObservableObject {
    
    @Published var startingOffsetY: CGFloat = UIScreen.main.bounds.height / 4.7
    @Published var currentDragOffsetY: CGFloat = 0
    @Published var endingOffsetY: CGFloat = 0
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
