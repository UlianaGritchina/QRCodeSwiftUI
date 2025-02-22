import SwiftUI

struct ShareQRButton: View {
    let qrCode: QRCode
    var body: some View {
        if #available(iOS 16.0, *) {
            shareLink
        } else {
            shareButton
        }
    }
}

struct ShareButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ShareQRButton(
            qrCode: QRCode(
                title: "",
                content: "",
                foregroundColor: RGBColor(color: .black),
                backgroundColor: RGBColor(color: .white),
                imageData: Data(),
                dateCreated: Date(),
                type: "text"
            )
        )
    }
}

extension ShareQRButton {
    
    private var shareButton: some View {
        Button(action: { showShareView() }) {
            Image(systemName: "square.and.arrow.up")
                .font(.system(size: 18))
        }
    }
    
    @ViewBuilder  private var shareLink: some View {
        if #available(iOS 16.0, *) {
            ShareLink(
                item:
                    Image(uiImage: (UIImage(data: qrCode.imageData)
                                    ?? UIImage(named: "defaultQRImage"))!),
                preview:
                    SharePreview(
                        "QR-code - \(qrCode.name)",
                        image:
                            Image(uiImage: (UIImage(data: qrCode.imageData)
                                            ?? UIImage(named: "defaultQRImage"))!))) {
                                                Image(systemName: "square.and.arrow.up")
                                                    .font(.system(size: 18))
                                            }
        }
    }
    
    private func showShareView() {
        let activityVC = UIActivityViewController(
            activityItems: [qrCode.imageData],
            applicationActivities: nil
        )
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let vc = window?.rootViewController
        activityVC.popoverPresentationController?.sourceView = vc?.view
        activityVC.popoverPresentationController?.sourceRect = .zero
        window?.rootViewController?.present(
            activityVC, animated: true, completion: nil
        )
    }
    
}
