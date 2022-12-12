
import SwiftUI

struct QRCodeDetailView: View {
    let qrCode: QRCode
    var body: some View {
        VStack {
            Spacer()
            QRCodeImageView(imageData: qrCode.imageData)
            Spacer()
            Spacer()
        }
        .navigationTitle(qrCode.name)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                ShareButtonView(codeImageData: qrCode.imageData, imageSize: 20)
            }
        }
    }
    
}

struct QRCodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeDetailView(
            qrCode: QRCode(name: "name", text: "text", imageData: Data())
        )
    }
}
