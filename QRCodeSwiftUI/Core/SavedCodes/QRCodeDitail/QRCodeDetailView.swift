
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
        .navigationTitle(viewModel.qrCode.title)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ShareQRButton(qrCode: viewModel.qrCode)
            }
        }
        .sheet(isPresented: $viewModel.isShowEditView, content: {
            MainView(editingQR: viewModel.qrCode)
        })
    }
    
}

struct QRCodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QRCodeDetailView(
                qrCode: QRCode(
                    title: "name",
                    content: "text",
                    foregroundColor: RGBColor(color: .red),
                    backgroundColor: RGBColor(color: .green),
                    imageData: (UIImage(named: "defaultQRImage")?.pngData())!,
                    dateCreated: Date()
                )
            )
        }
    }
}

extension QRCodeDetailView {
    
    private var buttons: some View {
        HStack(spacing: 10) {
            deleteButton
            editButton
            brightButton
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
    
    private var editButton: some View {
        CircleButton(
            imageName: "slider.horizontal.3",
            action: viewModel.showEditView
        )
    }
    
    private var brightButton: some View {
        CircleButton(imageName: viewModel.brightButtonImageName, action: {
            viewModel.didTapBrightButton()
            UIScreen.main.brightness = CGFloat(viewModel.isLightOn ? 1 : 0.5)
        })
    }
    
}
