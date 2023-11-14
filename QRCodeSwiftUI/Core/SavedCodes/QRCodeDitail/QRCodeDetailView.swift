
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
                buttons
            }
        }
        .navigationTitle(qrCode.name)
    }
    
}

struct QRCodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeDetailView(
            qrCode: QRCode(
                name: "name",
                text: "text",
                imageData: (UIImage(named: "defaultQRImage")?.pngData())!
            )
        )
    }
}

extension QRCodeDetailView {
    
    private var buttons: some View {
        HStack {
            Spacer()
            CircleButton(imageName: "trash", action: { })
            Spacer()
            shareButton
            Spacer()
            CircleButton(imageName: "sun.min", action: {})
            Spacer()
        }
        .padding()
        .padding(.bottom)
    }
    
    private var shareButton: some View {
        ShareButtonView(codeImageData: qrCode.imageData, imageSize: 18)
            .frame(width: 50, height: 50)
            .background(Color("cardBackground"))
            .cornerRadius(25)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 0)
    }
    
}
