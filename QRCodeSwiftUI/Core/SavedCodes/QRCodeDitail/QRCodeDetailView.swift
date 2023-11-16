
import SwiftUI

struct QRCodeDetailView: View {
    @ObservedObject private var viewModel: QRCodeDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(qrCode: QRCode) {
        viewModel = QRCodeDetailViewModel(qrCode: qrCode)
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                QrView(data: viewModel.qrCode.imageData, size: 300)
                Spacer()
                Spacer()
                buttons
            }
        }
        .navigationTitle(viewModel.qrCode.name)
    }
    
}

struct QRCodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeDetailView(
            qrCode: QRCode(
                name: "name",
                text: "text",
                imageData: (UIImage(named: "defaultQRImage")?.pngData())!,
                dateCreated: Date()
            )
        )
    }
}

extension QRCodeDetailView {
    
    private var buttons: some View {
        HStack {
            Spacer()
            deleteButton
            Spacer()
            shareButton
            Spacer()
            brightButton
            Spacer()
        }
        .padding()
        .padding(.bottom)
    }
    
    private var deleteButton: some View {
        CircleButton(imageName: "trash", action: {
            viewModel.deleteQRCode()
            dismiss()
        })
    }
    
    private var shareButton: some View {
        ShareQRButton(qrCode: viewModel.qrCode)
            .frame(width: 50, height: 50)
            .background(Color("cardBackground"))
            .cornerRadius(25)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 0)
    }
    
    private var brightButton: some View {
        CircleButton(imageName: viewModel.isLightOn ? "sun.max" : "sun.min", action: {
            viewModel.didTapBrightButton()
            UIScreen.main.brightness = CGFloat(viewModel.isLightOn ? 1 : 0.5)
        })
    }
    
}
