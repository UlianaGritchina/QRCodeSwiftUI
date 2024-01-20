
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ShareQRButton(qrCode: viewModel.qrCode)
            }
        }
        .sheet(isPresented: $viewModel.isShowEditView, content: {
            GenerateQRView(editingQR: $viewModel.qrCode, isEditingView: true)
        })
        .onChange(of: viewModel.qrCode) { _ in
            viewModel.updateQRInUserDefaults()
        }
        .alert(viewModel.deleteAlertTitel, isPresented: $viewModel.isShowAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.deleteQRCode()
                dismiss()
            }
        }
    }
    
}

struct QRCodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QRCodeDetailView(
                qrCode: QRCode(
                    title: "name",
                    content: "https://www.apple.com",
                    foregroundColor: RGBColor(color: .red),
                    backgroundColor: RGBColor(color: .green),
                    imageData: (UIImage(named: "defaultQRImage")?.pngData())!,
                    dateCreated: Date(),
                    type: "text"
                )
            )
        }
    }
}

extension QRCodeDetailView {
    
    private var buttons: some View {
        HStack(spacing: .zero) {
            deleteButton
            editButton
            brightButton
            browserButton
        }
        .padding()
        .padding(.bottom)
    }
    
    private var deleteButton: some View {
        Button(action: viewModel.deleteButtonDidTapp) {
            Image(systemName: "trash")
                .circleModifier()
                .padding()
        }
    }
    
    private var editButton: some View {
        Button(action: viewModel.showEditView) {
            Image(systemName: "slider.horizontal.3")
                .circleModifier()
                .padding()
        }
    }
    
    private var brightButton: some View {
        Button(action: {
            viewModel.didTapBrightButton()
            UIScreen.main.brightness = CGFloat(viewModel.isLightOn ? 1 : 0.5)
        }, label: {
            Image(systemName: viewModel.brightButtonImageName)
                .circleModifier()
                .padding()
        })
    }
    
    @ViewBuilder private var browserButton: some View {
        if let url = URL(string: viewModel.qrCode.textContent) {
            if UIApplication.shared.canOpenURL(url) {
                Link(destination: url, label: {
                    Image(systemName: "link")
                        .circleModifier()
                        .padding()
                })
            }
        }
    }
}
