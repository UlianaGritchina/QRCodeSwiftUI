
import SwiftUI

struct QRCodeDetailView: View {
    let qrCode: QRCode
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                QrView(data: qrCode.imageData, size: 300)
                Spacer()
                Spacer()
            }
        }
        .navigationTitle(qrCode.name)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                ShareButtonView(codeImageData: qrCode.imageData, imageSize: 18)
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
